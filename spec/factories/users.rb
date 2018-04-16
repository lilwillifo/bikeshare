FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "User #{n}" }
    password '123'
    password_confirmation '123'
    first_name 'Tyler'
    last_name 'Perry'
    address 'Far Away Land'
  end

  factory :admin, class: User do
    username 'Odin'
    password 'test'
    password_confirmation 'test'
    first_name 'Tyler'
    last_name 'Perry'
    address 'Far Away Land'
    role 1
  end
end
