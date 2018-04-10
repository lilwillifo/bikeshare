FactoryBot.define do
  factory :trip do
    sequence(:duration) {|n| n }
    start_date "2018-04-09 18:27:55"
    end_date "2018-04-09 22:27:55"
    bike_id 1
    subscription_type "Premium"
    zip_code 80202
    start_station_id 1
    end_station_id 1
  end
end
