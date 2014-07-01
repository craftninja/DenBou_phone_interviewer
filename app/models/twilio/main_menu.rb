class Twilio::MainMenu

  require 'nokogiri'

  def return_xml
    question = Question.first
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

end