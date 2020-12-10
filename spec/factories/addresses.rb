FactoryBot.define do
  factory :address do
    user nil
    city  { 'MyString' }
    state { 'MyString' }
  end
end
