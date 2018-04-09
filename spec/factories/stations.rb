FactoryBot.define do
  factory :station do
    sequence(:name) { |n| "Station #{n}" }
    dock_count 10
    city 'San Francisco'
    installation_date Date.new(2012,10,4)
  end
end
