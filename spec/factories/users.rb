FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "User #{n}" }
    password '123'
  end

  factory :admin, class: User do
    username 'Odin'
    password 'test'
    role 1
  end
end
