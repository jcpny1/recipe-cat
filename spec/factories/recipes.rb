FactoryBot.define do
  factory :recipe do
    name 'MyString'
    description 'MyText'
    photo_path ''
    total_time '120'
    author
  end
end
