class UserQuestion < ActiveRecord::Base

  validates_presence_of :user_id, :question_id

  after_create :asked_all_questions

  private

  def asked_all_questions
    user_questions = UserQuestion.where(user_id: user_id)
    if user_questions
      if user_questions.count == Question.count
        user_questions.delete_all
      end
    end
  end
end
