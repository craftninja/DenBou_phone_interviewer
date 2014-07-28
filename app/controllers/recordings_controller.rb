class RecordingsController < ApplicationController
  before_action :validate_registration

  def index
    @recordings = Recording.all
    @comment = Comment.new
  end

  private

  def validate_registration
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false if current_user.nil?
  end
end