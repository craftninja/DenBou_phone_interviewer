require 'spec_helper'

describe UserQuestion do

  let(:user_question) { UserQuestion.create!(user_id: 1, question_id: 1) }

  it 'must be created with a user id' do
    expect(user_question).to be_valid
    user_question.user_id = nil
    expect(user_question).to_not be_valid
  end

  it 'must be created with a question id' do
    expect(user_question).to be_valid
    user_question.question_id = nil
    expect(user_question).to_not be_valid
  end

  it 'should delete user_questions associated with a user if the number of them is equal to the total number of questions' do
    user = User.create!(phone_number: '1234567890')
    questions = Question.all
    questions.each do |question|
      UserQuestion.create!(user_id: user.id, question_id: question.id)
    end
    expect(UserQuestion.count).to eq 0
  end

end