FactoryBot.define do
  factory :accessory do
    sequence(:title) {|n| n }
    description 'Test accessory'
    price 5.00
    role 0
  end
end
