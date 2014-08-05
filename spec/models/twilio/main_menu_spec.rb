require 'spec_helper'

describe Twilio::MainMenu do

  describe "return_xml" do

    before do
      UserQuestion.delete_all
    end

    it 'will return a random question when a user has pressed 1' do
      user = User.create!(phone_number: '1234567890')
      create_question
      output = <<-OUTPUT
<?xml version="1.0"?>
<Response>
  <Say>Press any key when you have completed responding to the following question.</Say>
  <Pause/>
      OUTPUT

      recording = <<-RECORDING
<Record maxLength="60" action="/twilio/recordings"/>
</Response>
      RECORDING

      twilio_main_menu = Twilio::MainMenu.new
      result = twilio_main_menu.ask_question(user)
      doc = Nokogiri.XML(result)
      expect(doc.xpath('//Say').children.count).to eq 2
      expect(doc.xpath('//Say').children.last.text).to match /[\w\W]{7,}/
      expect(result).to include output
      expect(result).to include recording
    end

    it 'will add the question to the users list of answered question' do
      user = User.create!(phone_number: '1234567890')
      create_question
      create_question('What is your biggest weakness?')
      twilio_main_menu = Twilio::MainMenu.new
      expect(UserQuestion.count).to eq 0
      twilio_main_menu.ask_question(user)
      expect(UserQuestion.count).to eq 1
      expect(UserQuestion.first.user_id).to eq user.id
    end

  it 'will not ask the same question twice' do
      user = User.create!(phone_number: '1234567890')
      twilio_main_menu = Twilio::MainMenu.new
      question1 = create_question
      question2 = create_question('What is your biggest weakness?')
      question3 = create_question('Why do you want this job?')
      question4 = create_question('Why are you leaving your present job?')
      question5 = create_question('When were you most satisfied in your job?')
      UserQuestion.create!(user_id: user.id, question_id: question1.id)
      UserQuestion.create!(user_id: user.id, question_id: question2.id)
      UserQuestion.create!(user_id: user.id, question_id: question3.id)
      UserQuestion.create!(user_id: user.id, question_id: question4.id)
      UserQuestion.create!(user_id: user.id, question_id: question5.id)
      text = []
      text << question1.question
      text << question2.question
      text << question3.question
      text << question4.question
      text << question5.question

      result = twilio_main_menu.ask_question(user)
      doc = Nokogiri.XML(result)
      text << doc.xpath('//Say').children.last.text
      expect(text.uniq.length).to eq 5
    end

  end

  describe "hangup" do

    it 'it builds the twiml to hang up the phone' do
      output = <<-OUTPUT
<?xml version="1.0"?>
<Response>
  <Say>Thanks for calling! Any recordings will now be available on your profile page.</Say>
  <Hangup/>
</Response>
      OUTPUT

      twilio_main_menu = Twilio::MainMenu.new
      expect(twilio_main_menu.hang_up).to eq output
    end

  end
end