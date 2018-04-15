class Trip < ApplicationRecord
  include ActionView::Helpers::TextHelper

  validates_presence_of :duration, :start_date, :start_station_id, :end_date, :end_station_id, :bike_id, :subscription_type

  belongs_to :start_station, class_name: 'Station'
  belongs_to :end_station, class_name: 'Station'
  belongs_to :condition, optional: true

  def time_string
    seconds = duration

    values.reduce([]) do |string, (per, name)|
      if seconds > 0
        seconds, amt = seconds.divmod(per)
        string.unshift "#{pluralize(amt, name.to_s)}"
      end
      string
    end.join(', ')
  end

  def self.average_duration
    average(:duration)
  end

  def self.longest_ride
    maximum(:duration)
  end

  def self.shortest_ride
    minimum(:duration)
  end

  def self.popular_start_station
    Station.find(pop_start_station_id).name
  end

  def self.popular_end_station
    Station.find(pop_end_station_id).name
  end

  def self.most_ridden_bike
    most_ridden.keys.first
  end

  def self.most_ridden_bike_count
    most_ridden.values.first
  end

  def self.least_ridden_bike
    least_ridden.keys.first
  end

  def self.least_ridden_bike_count
    least_ridden.values.first
  end

  def self.customers_count
    where(subscription_type: 'Customer').count
  end

  def self.customers_percentage
    (customers_count.to_f / all.count).round(2) * 100
  end

  def self.subscribers_count
    where(subscription_type: 'Subscriber').count
  end

  def self.subscribers_percentage
    (subscribers_count.to_f / all.count).round(2) * 100
  end

  private
  def values
    [
      [60, :second],
      [60, :minute],
      [24, :hour]
    ]
  end

  def self.most_ridden
    group(:bike_id).order('count(bike_id) DESC').limit(1).count(:id)
  end

  def self.least_ridden
    group(:bike_id).order('count(bike_id)').limit(1).count(:id)
  end

  def self.pop_start_station_id
    group(:start_station_id).order('count(id) DESC').count.keys.first
  end

  def self.pop_end_station_id
    group(:end_station_id).order('count(id) DESC').count.keys.first
  end
end
