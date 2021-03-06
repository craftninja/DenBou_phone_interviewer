require 'spec_helper'

feature 'user show page' do

  scenario 'a user can see a list of their recordings on their profile page and log out' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    question = create_question
    Recording.create!(recording: 'http://www.recording.com', user_id: user.id, question_id: question.id)
    visit "/users/#{user.id}"
    expect(page).to have_content("#{question.question}")

    click_link 'Logout'
    expect(page).to have_content('Logged out!')
    expect(page).to_not have_content("#{question.question}")
    expect(page).to have_content('Login with LinkedIn')

    click_link 'Login with LinkedIn'
    expect(page).to have_content("#{question.question}")
    expect(page).to_not have_content("Phone number")
  end

  scenario "the recordings on the user's page are automatically checked as public" do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    question = create_question
    Recording.create!(recording: 'http://www.recording.com', user_id: user.id, question_id: question.id)
    visit "/users/#{user.id}"
    expect(page).to have_content("#{question.question}")
    my_box = find('.check-box')
    expect(my_box).to be_checked
    uncheck('check-box')
    expect(my_box).to_not be_checked
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
    expect(page).to have_content("Answer questions now: (646) 679-2429")

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
    expect(page).to have_content 'Current phone number: (949) 949-9499'
    click_link 'Update Phone Number'
    expect(page).to have_button 'Update Number'
  end

  scenario 'a users recordings should be ordered by date' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    question1 = create_question
    question2 = create_question('What is your biggest weakness?')
    Recording.create!(user_id: user.id, question_id: question1.id, recording: "http://recording.com", created_at: "2014-07-06 17:00:17")
    Recording.create!(user_id: user.id, question_id: question2.id, recording: "http://recording.com", created_at: "2014-07-05 16:00:17")
    visit "/users/#{user.id}"
    within first('.user_recording') do
      expect(page).to have_content 'July 6, 2014'
      expect(page).to have_content 'What is your biggest strength?'
    end
    within page.all('.user_recording').last do
      expect(page).to have_content 'July 5, 2014'
      expect(page).to have_content 'What is your biggest weakness?'
    end
  end

  scenario 'User has profile pic and email on their profile page' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    visit "/users/#{user.id}"
    expect(page).to have_content('mock@email.com')
    expect(page).to have_xpath("//img[@src = 'http://cdn.cutestpaw.com/wp-content/uploads/2014/02/l-Angora-Bunny-with-a-haircut.jpg']")
  end

end
