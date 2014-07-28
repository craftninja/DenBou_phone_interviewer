require 'spec_helper'

describe "Recording Comments" do
  it "lists all recordings for registered users and renders error for non-registered users" do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    questions = Question.all
    Recording.create!(user_id: user.id, question_id: questions[0].id, recording: "http://recording.com", created_at: "2014-07-06 17:00:17")
    Recording.create!(user_id: user.id, question_id: questions[1].id, recording: "http://recording.com", created_at: "2014-07-05 16:00:17")
    visit "/recordings"

    expect(page).to have_content 'July 6, 2014'
    expect(page).to have_content 'What is your biggest strength?'
    expect(page).to have_content 'July 5, 2014'
    expect(page).to have_content 'What is your biggest weakness?'

    visit "/users/#{user.id}"
    click_link "Logout"

    visit "/recordings"

    expect(page).to have_content "The page you were looking for doesn't exist."
  end

  it " allows users to comment on recordings" do
    mock_auth_hash
    visit '/'
    click_link 'Login with LinkedIn'
    user = User.first
    user.update(phone_number: '9499499499')
    questions = Question.all
    Recording.create!(user_id: user.id, question_id: questions[0].id, recording: "http://recording.com", created_at: "2014-07-06 17:00:17")
    Recording.create!(user_id: user.id, question_id: questions[1].id, recording: "http://recording.com", created_at: "2014-07-05 16:00:17")
    visit "/recordings"

    within first(".comment_container") do
      fill_in "comment[body]", with: "This is a sweet answer"
      click_button "Add Comment"
    end

    within first(".user_recording") do
      expect(page).to have_content "This is a sweet answer"
      expect(page).to have_content "#{user.first_name}"
    end
  end

end