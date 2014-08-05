module Twilio
  class RecordingsController < ApplicationController

    skip_before_filter :verify_authenticity_token

    def create
      recording_url = params[:RecordingUrl]
      phone_number = params[:Caller].slice(2..-1)
      user = User.find_by(phone_number: phone_number)
      if user.nil?
        xml = Twilio::MainMenu.new.phone_number_is_invalid
      else
        question_id = UserQuestion.last.question_id
        Recording.create!(recording: recording_url, user_id: user.id, question_id: question_id)
        xml = Twilio::MainMenu.new.secondary_menu
      end
      render xml: xml
    end

    def update
      @recording = Recording.find(params[:recording_id])
      if params[:value] == "0"
        @recording.update_attributes(public: false)
      else
        @recording.update_attributes(public: true)
      end
    end
  end
end