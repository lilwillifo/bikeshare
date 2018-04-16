class Station < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name, :dock_count, :city, :installation_date
  has_many :start_trips, class_name: 'Trip', foreign_key: 'start_station_id', dependent: :destroy
  has_many :end_trips, class_name: 'Trip', foreign_key: 'end_station_id', dependent: :destroy

  def self.avg_bikes
    average(:dock_count).to_i
  end

  def self.max_bike_count
    maximum(:dock_count)
  end

  def self.max_bikes
    where(dock_count: maximum(:dock_count))
  end

  def self.min_bike_count
    minimum(:dock_count)
  end

  def self.min_bikes
    where(dock_count: minimum(:dock_count))
  end

  def self.newest
    find_by(installation_date: maximum(:installation_date))
  end

  def self.oldest
    find_by(installation_date: minimum(:installation_date))
  end

  def most_frequent_destination
    start_trips
      .select('end_station_id, COUNT(end_station_id) AS count')
      .group(:end_station_id)
      .order('count DESC')
      .first
      .end_station
  end

  def most_frequent_origin
    end_trips
      .select('start_station_id, COUNT(start_station_id) AS count')
      .group(:start_station_id)
      .order('count DESC')
      .first
      .start_station
  end

  def date_with_most_trips
    start_trips
      .select('date(trips.start_date) as date, count(date(start_date)) AS count')
      .group('date(start_date)')
      .to_a
      .first
      .date
      .to_date
  end

  def most_frequent_zip_code
    start_trips
      .select('zip_code, count(zip_code) AS count')
      .group(:zip_code)
      .to_a
      .first
      .zip_code
  end

  def most_frequent_bike
    start_trips
      .select('bike_id, count(bike_id) AS count')
      .group(:bike_id)
      .to_a
      .first
      .bike_id
  end
end
