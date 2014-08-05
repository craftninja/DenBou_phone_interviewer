def create_question(question = 'What is your biggest strength?')
  Question.create!(question: question, category: 'general')
end
