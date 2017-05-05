require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) { @user = User.new(email: 'user@example.com', role: :user) }

  it "has an email" do
    expect(@user.email).to match 'user@example.com'
  end

  it "has a role" do
    expect(@user.role).to eq('user')
  end

end
