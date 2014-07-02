require 'spec_helper'

describe User do

  it 'validates that a phone number is correctly formatted' do
    user = User.create!(phone_number: "9499100948")
    expect(user).to be_valid
    user.phone_number = "123453487"
    expect(user).to_not be_valid
    user.phone_number = "9499100948"
    expect(user).to be_valid
    user.phone_number = "23498723947"
    expect(user).to_not be_valid
  end

end