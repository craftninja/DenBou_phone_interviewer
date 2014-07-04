require "spec_helper"

describe 'get /main-menu.xml' do

  it "renders proper xml to tell Twilio to ask a question" do
    get '/twilio/main-menu.xml'

    expected_response = <<-INPUT
<Response>
  <Gather action="/twilio/main-menu">
    <Say>Welcome to Phone Interviewer. Please press 1 for a general question.</Say>
  </Gather>
</Response>
    INPUT

    expect(response.code.to_i).to eq 200
    expect(response.body).to eq(expected_response)
  end

  it "can take POST with Digits params = 1 and tell Twilio to ask a question" do
    User.create!(phone_number: '8595360335')
    post '/twilio/main-menu', {"AccountSid"=>"ACb3bfd82c42042b28e7031bc91ff60f78", "ToZip"=>"", "FromState"=>"KY", "Called"=>"+16466792429", "FromCountry"=>"US", "CallerCountry"=>"US", "CalledZip"=>"", "Direction"=>"inbound", "FromCity"=>"LEXINGTON", "CalledCountry"=>"US", "CallerState"=>"KY", "CallSid"=>"CA277327740131f951b9b2190f25e8acbf", "CalledState"=>"NY", "From"=>"+18595360335", "CallerZip"=>"40505", "FromZip"=>"40505", "CallStatus"=>"in-progress", "ToCity"=>"", "ToState"=>"NY", "To"=>"+16466792429", "Digits"=>"1", "ToCountry"=>"US", "msg"=>"Gather End", "CallerCity"=>"LEXINGTON", "ApiVersion"=>"2010-04-01", "Caller"=>"+18595360335", "CalledCity"=>""}

    expected_xml = <<-INPUT
<?xml version="1.0"?>
<Response>
  <Say>Press any key when you have completed responding to the following question.</Say>
  <Pause/>
    INPUT

    recording = <<-INPUT2
  <Record maxLength="60" action="/twilio/recordings"/>
</Response>
    INPUT2

    result = response.body
    doc = Nokogiri.XML(result)
    expect(doc.xpath('//Say').children.count).to eq 2
    expect(doc.xpath('//Say').children.last.text).to match /[\w\W]{7,}/

    expect(result).to include expected_xml
    expect(result).to include recording
  end

  it "can take a recording url and add it to the users recordings" do
    User.create!(phone_number: "8595360335")
    expect(Recording.count).to eq 0
    post '/twilio/recordings', {"AccountSid"=>"ACb3bfd82c42042b28e7031bc91ff60f78", "ToZip"=>"", "FromState"=>"KY", "Called"=>"+16466792429", "FromCountry"=>"US", "CallerCountry"=>"US", "CalledZip"=>"", "Direction"=>"inbound", "FromCity"=>"LEXINGTON", "CalledCountry"=>"US", "CallerState"=>"KY", "CallSid"=>"CAbc3fffdd172604e10d98ab13a1811233", "CalledState"=>"NY", "From"=>"+18595360335", "CallerZip"=>"40505", "FromZip"=>"40505", "CallStatus"=>"in-progress", "ToCity"=>"", "ToState"=>"NY", "RecordingUrl"=>"http://api.twilio.com/2010-04-01/Accounts/ACb3bfd82c42042b28e7031bc91ff60f78/Recordings/RE2ee69fba0eb26f9e39b2c4b82ed24a6d", "To"=>"+16466792429", "Digits"=>"5", "ToCountry"=>"US", "RecordingDuration"=>"6", "CallerCity"=>"LEXINGTON", "ApiVersion"=>"2010-04-01", "Caller"=>"+18595360335", "CalledCity"=>"", "RecordingSid"=>"RE2ee69fba0eb26f9e39b2c4b82ed24a6d", "controller"=>"twilio/base", "action"=>"recording"}
    expect(Recording.count).to eq 1
    expected_xml = <<-INPUT
<?xml version="1.0"?>
<Response>
  <Say>Thanks for calling!</Say>
  <Hangup/>
</Response>
    INPUT
    expect(response.body).to eq expected_xml
  end
end