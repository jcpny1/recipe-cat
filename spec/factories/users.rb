FactoryBot.define do
  factory :user, aliases: [:author] do
    email    { 'jim_user@aol.com' }
    password { '123456' }
    role     { 'user' }
  end
end
