class Comment < ActiveRecord::Base

  belongs_to :recording
  belongs_to :user
  validates_presence_of :body, :user_id, :recording_id
end
