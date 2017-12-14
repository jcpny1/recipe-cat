require 'rails_helper'

RSpec.describe Unit, type: :model do
  before do
    @unit = Unit.create!(name: 'lbs')
  end

  it 'has a name' do
    expect(@unit.name).to eq('lbs')
  end
end
