# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.foreach('./db/csv/station.csv', headers: true, header_converters: :symbol) do |station|
  station.delete(:lat)
  station.delete(:long)
  station[:installation_date] = Date.strptime(station[:installation_date], '%m/%d/%Y')
  Station.create!(station.to_h)
end
