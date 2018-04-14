FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "User #{n}" }
    password '123'
    password_confirmation '123'
  end

  factory :admin, class: User do
    username 'Odin'
    password 'test'
    password_confirmation 'test'
    role 1
  end
end
