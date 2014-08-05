class CommentsController < ApplicationController

  def create
    @comment = Comment.new(strong_params)
    @comment.user_id = current_user.id
    if @comment.save
      comment = {
        body: @comment.body,
        user_first_name: @comment.user.first_name,
        created_at: @comment.created_at
      }
      render json: comment.to_json
    else
      render 'recordings/index'
    end
  end

  private

  def strong_params
    params.require(:comment).permit(:body, :recording_id)
  end

end

