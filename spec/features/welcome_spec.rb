require 'spec_helper'
include OmniauthMacros

feature 'welcome page' do

  scenario 'user can view the homepage with a welcome message' do
    visit '/'
    expect(page).to have_content 'Welcome to PhoneInterviewer'
  end

  scenario 'user can login with LinkedIn' do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    expect(page).to have_content 'Welcome, Nathanael!'
  end

  scenario 'user can see their pin on the homepage' do
    srand(8675309)
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    expect(page).to have_content 'Your Super-Secret PIN # is: 5609'
    srand(Random.new_seed)
  end

end
