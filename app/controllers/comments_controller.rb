class CommentsController < ApplicationController

  def create
    @comment = Comment.new(strong_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to recordings_path
    else
      render 'recordings/index'
    end
  end

  private

  def strong_params
    params.require(:comment).permit(:body, :recording_id)
  end

end

