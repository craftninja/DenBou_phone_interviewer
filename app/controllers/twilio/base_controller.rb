module Twilio
  class BaseController < ApplicationController

    skip_before_filter :verify_authenticity_token

    def main_menu

    end

    def create
      phone_number = params[:Caller].slice(2..-1)
      user = User.find_by(phone_number: phone_number)
      xml = Twilio::MainMenu.new.return_xml(user)
      render xml: xml
    end

  end
end