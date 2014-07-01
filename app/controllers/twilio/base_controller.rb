class Twilio::BaseController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def main_menu

  end

  def create
    xml = Twilio::MainMenu.new.return_xml
    render xml: xml
  end

end