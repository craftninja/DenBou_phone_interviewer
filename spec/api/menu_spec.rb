require "spec_helper"

describe 'get /main-menu.xml' do

  it "renders proper xml to tell Twilio to ask a question" do
    get '/main-menu.xml'

    expected_response = <<-INPUT
<Response>
  <Gather action="/main-menu">
    <Say>Welcome to Phone Interviewer. Please press 1 for a general question.</Say>
  </Gather>
</Response>
    INPUT

    expect(response.code.to_i).to eq 200
    expect(response.body).to eq(expected_response)
  end
end