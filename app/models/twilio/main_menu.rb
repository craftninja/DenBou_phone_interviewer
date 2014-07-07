class Twilio::MainMenu

  def ask_question(user)
    asked_questions = UserQuestion.where(user_id: user.id)
    ids = asked_questions.map { |user_question| user_question.question_id }
    question = Question.limit(1).order("RANDOM()").first
    while ids.include?(question.id)
      question = Question.limit(1).order("RANDOM()").first
    end
    UserQuestion.create!(:user_id => user.id, :question_id => question.id)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Response {
        xml.Say "Press any key when you have completed responding to the following question."
        xml.Pause
        xml.Say question.question
        xml.Record(:maxLength => 60, :action => "/twilio/recordings")
      }
    end
    builder.to_xml
  end

  def secondary_menu
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Response {
        xml.Gather(:action => "/twilio/secondary-menu") {
          xml.Say "Please press 1 for another general question. Please press 2 to hang up."
        }
      }
    end
    builder
  end

  def secondary_menu_response(digit, user)
    if digit.to_i == 1
      ask_question(user)
    elsif digit.to_i == 2
      hang_up
    end
  end

  def hang_up
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Response {
        xml.Say "Thanks for calling! Any recordings will now be available on your profile page."
        xml.Hangup
      }
    end
    builder.to_xml
  end

end