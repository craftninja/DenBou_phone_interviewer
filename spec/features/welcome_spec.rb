require 'spec_helper'

feature 'welcome page' do

  scenario 'user can view the homepage with a welcome message' do
    visit '/'
    expect(page).to have_content 'Welcome to PhoneInterviewMe'
  end

  scenario 'user can login with LinkedIn' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    expect(page).to have_content 'Welcome, Nathanael!'
  end

  scenario 'user is notified upon a failed login with linkedin' do
    silence_omniauth do
      OmniAuth.config.mock_auth[:linkedin] = :invalid
      visit '/'
      click_link 'Login with LinkedIn'
      expect(page).to have_content 'Authorization with LinkedIn has failed, please retry.'
    end
  end

  scenario 'user enters their phone number upon successful login' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    expect(page).to_not have_content 'Your Super-Secret PIN'
    expect(page).to_not have_content 'To start answering interview questions, call: (646) 679-2429'
    fill_in 'user[phone_number][phone_number1]', with: '234'
    fill_in 'user[phone_number][phone_number2]', with: '789-9874'
    click_button 'Add'
    expect(page).to have_content 'Current phone number: (234) 789-9874'
    expect(page).to have_link 'Update Phone Number'
  end

  scenario 'user is assigned a cookie that expires in 60 days after adding their phone number' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    fill_in 'user[phone_number][phone_number1]', with: '234'
    fill_in 'user[phone_number][phone_number2]', with: '789- 9874'
    click_button 'Add'
    visit '/'
    expect(page).to have_content 'Answer questions now: (646) 679-2429'
    travel_to(60.days.from_now) do
      user = User.first
      visit "/users/#{user.id}"
      expect(page).to have_content 'Login with LinkedIn'
    end
  end

  scenario 'a user should not see Recordings if they do not have any' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    fill_in 'user[phone_number][phone_number1]', with: '234'
    fill_in 'user[phone_number][phone_number2]', with: '789 -9874'
    click_button 'Add'
    expect(page).to have_content 'Answer questions now: (646) 679-2429'
    expect(page).to_not have_content 'Recordings'
  end

  scenario 'a user should not be able to visit their show page if they do not have a phone number' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    visit "/users/#{user.id}"
    expect(page).to_not have_content 'My Recordings'
    expect(page).to have_button 'Add Number'
  end

end
