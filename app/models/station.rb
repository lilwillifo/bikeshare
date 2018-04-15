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
end
