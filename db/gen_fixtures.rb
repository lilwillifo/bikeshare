require 'csv'
require 'pry'

stations = []
station_ids = []
trips = []
weather = []

trip_zips = {}
trip_stations = Hash.new(0)

NUM_TRIPS = 20

CSV.foreach('./db/csv/station.csv', headers: true) do |station|
  stations.push(station)
  station_ids.push(station['id'].to_i)
end

MAX_TRIPS = stations.length * NUM_TRIPS

puts "Loaded #{stations.length} stations"
puts "Should load maximum of #{MAX_TRIPS} trips..."
CSV.foreach('./db/csv/trip.csv', headers: true) do |trip|
  next if(trip_stations[trip['start_station_id']] >= NUM_TRIPS)

  trips.push(trip)
  trip_stations[trip['start_station_id']] += 1
  trip_zips[trip['zip_code']] ||= []
  trip_zips[trip['zip_code']].push(trip['start_date'].split[0])

  break if trip_stations.values.sum >= MAX_TRIPS
end

puts "Loaded #{trips.length} trips"

CSV.foreach('./db/csv/weather.csv', headers: true) do |condition|
  if trip_zips.include?(condition['zip_code'])
    weather.push(condition) if trip_zips[condition['zip_code']].include?(condition['date'])
  end
end

puts "Loaded #{weather.length} weather conditions"
puts ""

CSV.open('./db/fixture/stations.csv', 'wb', write_headers: true, headers: stations.first.headers) do |csv|
  stations.each do |station|
    csv << station
  end
end

puts "Wrote #{stations.length} stations to fixture file"

CSV.open('./db/fixture/trip.csv', 'wb', write_headers: true, headers: trips.first.headers) do |csv|
  trips.each do |trip|
    csv << trip
  end
end

puts "Wrote #{trips.length} trips to fixture file"

CSV.open('./db/fixture/weather.csv', 'wb', write_headers: true, headers: weather.first.headers) do |csv|
  weather.each do |condition|
    csv << condition
  end
end

puts "Wrote #{weather.length} weather conditions to fixture file"
