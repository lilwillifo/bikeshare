FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "User #{n}" }
    password '123'
  end
end
