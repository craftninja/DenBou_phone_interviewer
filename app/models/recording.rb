class Recording < ActiveRecord::Base
  has_many :comments
  belongs_to :question
  belongs_to :user

  scope :open_to_public, -> { where(public: true) }
end