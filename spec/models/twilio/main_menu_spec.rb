require 'spec_helper'

describe Twilio::MainMenu do

  it 'will return a question when a user has pressed 1' do
    output = <<-OUTPUT
<?xml version="1.0"?>
<Response>
  <Say>Press any key when you have completed responding to the following question.</Say>
  <Pause/>
  <Say>What is your biggest strength?</Say>
  <Record maxLength="60" action="/twilio/recordings"/>
</Response>
    OUTPUT

    twilio_main_menu = Twilio::MainMenu.new
    expect(twilio_main_menu.return_xml).to eq output
  end

end