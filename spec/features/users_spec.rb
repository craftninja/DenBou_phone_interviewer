require 'spec_helper'

feature 'user show page' do

  scenario 'a user should see a list of their recordings on their profile page' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    Recording.create(recording: 'http://www.recording.com', user_id: user.id, question_id: Question.first.id)
    visit "/users/#{user.id}"
    expect(page).to have_content 'What is your biggest strength?'
    expect(page).to have_content 'http://www.recording.com'
  end
end