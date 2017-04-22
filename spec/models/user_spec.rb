require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) { @user = User.new(email: 'user@example.com') }

  it "has an email" do
    expect(@user.email).to match 'user@example.com'
  end
end
