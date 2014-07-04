require 'spec_helper'

describe Twilio::MainMenu do

  describe "return_xml" do

    before do
      UserQuestion.delete_all
    end

    it 'will return a random question when a user has pressed 1' do
      user = User.create!(phone_number: '1234567890')
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
      result = twilio_main_menu.return_xml(user)
      doc = Nokogiri.XML(result)
      expect(doc.xpath('//Say').children.count).to eq 2
      expect(doc.xpath('//Say').children.last.text).to match /[\w\W]{7,}/
      expect(result).to include output
      expect(result).to include recording
    end

    it 'will add the question to the users list of answered question' do
      user = User.create!(phone_number: '1234567890')
      twilio_main_menu = Twilio::MainMenu.new
      expect(UserQuestion.count).to eq 0
      twilio_main_menu.return_xml(user)
      expect(UserQuestion.count).to eq 1
      expect(UserQuestion.first.user_id).to eq user.id
    end

  end

  describe "hangup" do

    it 'it builds the twiml to hang up the phone' do
      output = <<-OUTPUT
<?xml version="1.0"?>
<Response>
  <Say>Thanks for calling!</Say>
  <Hangup/>
</Response>
      OUTPUT

      twilio_main_menu = Twilio::MainMenu.new
      expect(twilio_main_menu.hang_up).to eq output
    end

  end
end