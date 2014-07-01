require "spec_helper"

describe 'get /main-twilio.xml' do

  it "renders proper xml to tell Twilio to ask a question" do
    get '/twilio/main-twilio.xml'

    expected_response = <<-INPUT
<Response>
  <Gather action="/main-twilio">
    <Say>Welcome to Phone Interviewer. Please press 1 for a general question.</Say>
  </Gather>
</Response>
    INPUT

    expect(response.code.to_i).to eq 200
    expect(response.body).to eq(expected_response)
  end

  it "can take POST with Digits params = 1 and tell Twilio to ask a question" do
    post '/twilio/main-twilio', {"AccountSid"=>"ACb3bfd82c42042b28e7031bc91ff60f78", "ToZip"=>"", "FromState"=>"KY", "Called"=>"+16466792429", "FromCountry"=>"US", "CallerCountry"=>"US", "CalledZip"=>"", "Direction"=>"inbound", "FromCity"=>"LEXINGTON", "CalledCountry"=>"US", "CallerState"=>"KY", "CallSid"=>"CA277327740131f951b9b2190f25e8acbf", "CalledState"=>"NY", "From"=>"+18595360335", "CallerZip"=>"40505", "FromZip"=>"40505", "CallStatus"=>"in-progress", "ToCity"=>"", "ToState"=>"NY", "To"=>"+16466792429", "Digits"=>"1", "ToCountry"=>"US", "msg"=>"Gather End", "CallerCity"=>"LEXINGTON", "ApiVersion"=>"2010-04-01", "Caller"=>"+18595360335", "CalledCity"=>""}

    expected_xml = <<-INPUT
<Response>
  <Say>Press any key when you have completed responding to the following question.</Say>
  <Pause/>
  <Say>What is your biggest weakness?</Say>
  <Record maxLength=60 transcribe=true action="/recordings"/>
</Response>
      INPUT


  end
end