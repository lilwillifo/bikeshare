FactoryBot.define do
  factory :condition do
    date '2002-06-10'
    max_temperature 88
    mean_temperature 84
    min_temperature 80
    mean_humidity 99
    mean_visibility 15
    mean_wind_speed 25
    precipitation 1
  end
end
