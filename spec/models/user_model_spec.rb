require 'spec_helper'


describe User do
  it "validates that the PIN is unique" do
    user = User.create!(
      :provider => "LinkedIn",
      :uid => "asdfqewrty",
      :access_token => "asdflkjwer",
      :email => "nate@example.com",
      :first_name => "Nate",
      :last_name => "Example",
      :pin => "1234"
    )
    expect(user).to be_valid

    user2 = User.new(
      :provider => "LinkedIn",
      :uid => "asdfqewrty",
      :access_token => "asdflkjwer",
      :email => "nathan@example.com",
      :first_name => "Nathan",
      :last_name => "Eggsample",
      :pin => "1234"
    )
    expect(user2).to_not be_valid

  end
end
