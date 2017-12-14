require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @user = User.create!(email: 'user@aol.com', password: 'littlesprout' )
    @user.address.city = 'Freeport'
    @user.address.state = 'NY'
  end

  it 'has a city' do
    expect(@user.address.city).to eq('Freeport')
  end

  it 'has a state' do
    expect(@user.address.state).to eq('NY')
  end
end
