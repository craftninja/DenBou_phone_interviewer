require 'spec_helper'

feature 'user show page' do

  scenario 'a user can see a list of their recordings on their profile page and log out' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    question = Question.all[8]
    Recording.create!(recording: 'http://www.recording.com', user_id: user.id, question_id: question.id)
    visit "/users/#{user.id}"
    expect(page).to have_link("#{question.question}")

    click_link 'Logout'
    expect(page).to have_content('Logged out!')
    expect(page).to_not have_link("#{question.question}")
    expect(page).to have_content('Login with LinkedIn')

    click_link 'Login with LinkedIn'
    expect(page).to have_link("#{question.question}")
    expect(page).to_not have_content("Phone number")
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
    expect(page).to have_content("To start answering interview questions, call: (646) 679-2429")

    visit "/users/#{user2.id}"
    expect(page).to have_content "The page you were looking for doesn't exist."

    visit "/users/#{user2.id}/edit"
    expect(page).to have_content "The page you were looking for doesn't exist."


  end

  scenario 'a user has an edit phone number button on their profile page' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    visit "/users/#{user.id}"
    expect(page).to have_content 'Your current phone number is: (949) 949-9499'
    click_link 'Update Phone Number'
    expect(page).to have_content 'Phone number'
  end

  scenario 'a users recordings should be ordered by date' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    Recording.create!(user_id: user.id, question_id: 2, recording: "http://recording.com", created_at: "2014-07-06 17:00:17")
    Recording.create!(user_id: user.id, question_id: 1, recording: "http://recording.com", created_at: "2014-07-05 16:00:17")
    visit "/users/#{user.id}"
    within first('.one_third') do
      expect(page).to have_content 'July 6, 2014'
      expect(page).to have_content 'What is your biggest weakness?'
    end
    within page.all('.one_third').last do
      expect(page).to have_content 'July 5, 2014'
      expect(page).to have_content 'What is your biggest strength?'
    end
  end
end
