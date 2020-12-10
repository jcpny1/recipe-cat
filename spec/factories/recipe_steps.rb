FactoryBot.define do
  factory :recipe_step do
    step_number { 1 }
    description { 'MyText' }
    recipe      { '' }
  end
end
