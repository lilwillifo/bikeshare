require 'csv'
require 'pry'

stations = []
station_ids = []
trips = []
weather = []

trip_zips = {}

NUM_STATIONS = 15
NUM_TRIPS = 1500

CSV.foreach('./db/csv/station.csv', headers: true) do |station|
  if stations.length == NUM_STATIONS
    break
  end
  stations.push(station)
  station_ids.push(station['id'].to_i)
end

puts "Loaded #{stations.length} stations"

CSV.foreach('./db/csv/trip.csv', headers: true) do |trip|
  if station_ids.include?(trip['start_station_id'].to_i) && station_ids.include?(trip['end_station_id'].to_i)
    trips.push(trip)
    trip_zips[trip['zip_code']] ||= []
    trip_zips[trip['zip_code']].push(trip['start_date'].split[0])
  end

  break if trips.length >= NUM_TRIPS
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
