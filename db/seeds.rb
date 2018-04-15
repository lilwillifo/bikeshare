# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.foreach('./db/fixture/stations.csv', headers: true, header_converters: :symbol) do |station|
  station.delete(:lat)
  station.delete(:long)
  station[:installation_date] = Date.strptime(station[:installation_date], '%m/%d/%Y')
  Station.create!(station.to_h)
end

CSV.foreach('./db/fixture/weather.csv', headers: true, header_converters: :symbol) do |weather|
  condition = {
    date: Date.strptime(weather[:date], '%m/%d/%Y'),
    max_temperature: weather[:max_temperature_f],
    min_temperature: weather[:min_temperature_f],
    mean_temperature: weather[:mean_temperature_f],
    mean_humidity: weather[:mean_humidity],
    mean_visibility: weather[:mean_visibility_miles],
    mean_wind_speed: weather[:mean_wind_speed_mph],
    precipitation: weather[:precipitation_inches],
    zipcode: weather[:zip_code]
  }

  Condition.create!(condition)
end

CSV.foreach('./db/fixture/trip.csv', headers: true, header_converters: :symbol) do |trip|
  trip.delete(:start_station_name)
  trip.delete(:end_station_name)
  trip[:condition_id] = if Condition.find_by(date: Date.strptime(trip[:end_date], '%m/%d/%Y')).nil?
                            Condition.find_by(zipcode: trip[:zip_code])
                        else
                          Condition.find_by(date: Date.strptime(trip[:end_date], '%m/%d/%Y')).id
                        end
  trip[:start_date] = Time.strptime(trip[:start_date], '%m/%d/%Y %H:%M')
  trip[:end_date] = Time.strptime(trip[:end_date], '%m/%d/%Y %H:%M')

  Trip.create!(trip.to_h)
end


User.create!(username: 'fluffy', password: 'admin', role: 'admin')
User.create!(username: 'thrasher', password: 'user')

Accessory.create!(title: 'bike lock', description: 'locks things', price: 70)
Accessory.create!(title: 'front light', description: 'lights things', price: 20)
Accessory.create!(title: 'back light', description: 'lights things', price: 40)
Accessory.create!(title: 'water bottle', description: 'bottles water', price: 12)
Accessory.create!(title: 'gloves', description: 'warms hands', price: 35)
Accessory.create!(title: 'kickstand', description: 'holds a bike up', price: 18)
Accessory.create!(title: 'training wheels', description: 'kidz can ride', price: 10)
Accessory.create!(title: 'a thing', description: 'does something', price: 100)
Accessory.create!(title: 'seat bag', description: 'holds things', price: 24)
Accessory.create!(title: 'rear rack', description: 'holds things', price: 55)
Accessory.create!(title: 'basket', description: 'holds toto', price: 45)
Accessory.create!(title: 'spandex', description: 'emphasizes flaws', price: 90)
Accessory.create!(title: 'pedals', description: 'rotates things', price: 88)
Accessory.create!(title: 'old bike lock', description: 'locked things', price: 10, role: 1)
