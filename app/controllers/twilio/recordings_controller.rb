module Twilio
  class RecordingsController < ApplicationController

    def create
      recording_url = params[:RecordingUrl]
      phone_number = params[:Caller].slice(2..-1)
      user = User.find_by(phone_number: phone_number)
      Recording.create!(recording: recording_url, user_id: user.id, question_id: Question.first.id)
      xml = Twilio::MainMenu.new.hang_up
      render xml: xml
    end

  end
end