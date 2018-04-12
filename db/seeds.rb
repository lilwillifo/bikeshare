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
    precipitation: weather[:precipitation_inches]
  }

  Condition.create!(condition)
end

CSV.foreach('./db/fixture/trip.csv', headers: true, header_converters: :symbol) do |trip|
  trip.delete(:start_station_name)
  trip.delete(:end_station_name)

  trip[:start_date] = Time.strptime(trip[:start_date], '%m/%d/%Y %H:%M')
  trip[:end_date] = Time.strptime(trip[:end_date], '%m/%d/%Y %H:%M')

  Trip.create!(trip.to_h)
end

User.create!(username: 'fluffy', password: 'admin', role: 'admin')
