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

  scenario 'user enters their phone number upon successful login' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    expect(page).to_not have_content 'Your Super-Secret PIN'
    expect(page).to_not have_content 'Please call (646) 679-2429 to start answering interview questions!'
    fill_in 'user[phone_number]', with: '2347899874'
    click_button 'Add Phone Number'
    expect(page).to have_content 'Thank you for adding your phone number. The phone number you added was: (234) 789-9874.'
    expect(page).to have_content 'Please call (646) 679-2429 to start answering interview questions!'
  end

  scenario 'a user is redirected to their show page if the session is still valid' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    fill_in 'user[phone_number]', with: '2347899874'
    click_button 'Add Phone Number'
    visit '/'
    expect(page).to have_content 'Please call (646) 679-2429 to start answering interview questions!'
  end

end
