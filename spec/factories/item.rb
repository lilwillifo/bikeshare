FactoryBot.define do
  factory :item do
    sequence(:title) {|n| n }
    description 'Awesome item'
    price 5.00
  end
end
