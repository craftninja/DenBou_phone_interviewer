require 'spec_helper'

feature 'user show page' do

  scenario 'a user should see a list of their recordings on their profile page' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    question = Question.all[8]
    Recording.create!(recording: 'http://www.recording.com', user_id: user.id, question_id: question.id)
    visit "/users/#{user.id}"
    expect(page).to have_link("#{question.question}")
  end

  scenario "logged in user cannot visit another user's profile page" do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    user2 = User.create!(
        provider: "linkedin",
        uid: "0SfZdFU0cj",
        access_token: "AQUBRXSWHx2LBU0HjES_oaLEFKTU3dAYfcQmVAEDA0MGuMyQVJ...",
        email: "user2@mock.com",
        first_name: "User",
        last_name: "2",
        phone_number: "8555555555")

    visit "/users/#{user.id}"
    expect(page).to have_content("Please call (646) 679-2429 to start answering interview questions!")

    visit "/users/#{user2.id}"
    expect(page).to have_content "Forbidden Fruit, my friend. Please visit your own profile page."
  end

  scenario 'a user has an edit phone number button on their profile page' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    visit "/users/#{user.id}"
    expect(page).to have_content 'Your current phone number is: (949) 949-9499. Click here to update your phone number:'
    click_link 'Update Phone Number'
    expect(page).to have_content 'Phone number'
  end
end
