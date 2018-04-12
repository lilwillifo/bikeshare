FactoryBot.define do
  factory :condition do
    sequence(:id) {|n| n }
    date Date.new(2002,10,4)
    max_temperature 88
    mean_temperature 84
    min_temperature 80
    mean_humidity 99
    mean_visibility 15
    mean_wind_speed 25
    precipitation 1
  end
end
