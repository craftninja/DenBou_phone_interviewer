require 'spec_helper'

describe Question do
  it 'verifies that a question has been put into the database' do
    question = Question.new(:question => 'What color is your bunny?', :category => 'general')
    question.save
    expect(Question.all.first[:question]).to eq('What color is your bunny?')
  end
end
