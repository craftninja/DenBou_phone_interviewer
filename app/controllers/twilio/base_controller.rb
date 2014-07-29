module Twilio
  class BaseController < ApplicationController

    skip_before_filter :verify_authenticity_token

    def main_menu
      xml = Twilio::MainMenu.new.main_menu_response
      render xml: xml
    end

    def create
      phone_number = params[:Caller].slice(2..-1)
      user = User.find_by(phone_number: phone_number)
      if user.nil?
        xml = Twilio::MainMenu.new.phone_number_is_invalid
      else
        xml = Twilio::MainMenu.new.ask_question(user)
      end
      render xml: xml
    end

    def secondary_menu
      digit = params[:Digits]
      phone_number = params[:Caller].slice(2..-1)
      user = User.find_by(phone_number: phone_number)
      if user.nil?
        xml = Twilio::MainMenu.new.phone_number_is_invalid
      else
        xml = Twilio::MainMenu.new.secondary_menu_response(digit, user)
      end
      render xml: xml
    end

  end
end