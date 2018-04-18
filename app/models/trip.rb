class Trip < ApplicationRecord
  include ActionView::Helpers::TextHelper

  validates_presence_of :duration,
                        :start_date,
                        :start_station_id,
                        :end_date,
                        :end_station_id,
                        :bike_id,
                        :subscription_type

  enum subscription_type: ['Customer', 'Subscriber']

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

  def self.date_with_most_rides
    date_with_most_rides_result.keys.first.strftime('%m %d %Y')
  end

  def self.count_of_date_with_most_rides
    date_with_most_rides_result.values.first
  end

  def self.date_with_least_rides
    date_with_least_rides_result.keys.first.strftime('%m %d %Y')
  end

  def self.count_of_date_with_least_rides
    date_with_least_rides_result.values.first
  end

  def self.conditions_for_most_rides
    date = date_with_most_rides_result.keys.first.to_date
    Condition.find_by(date: date)
  end

  def self.conditions_for_lowest_rides
    date = date_with_least_rides_result.keys.first.to_date
    Condition.find_by(date: date)
  end

  def self.group_rides_by_month
    group("DATE_TRUNC('month', end_date)").count
  end

  def self.group_rides_by_year
    group("DATE_TRUNC('year', end_date)").count
  end

  def self.include_years_for_rides
    months = group_rides_by_month
    form = months.keys.sort.map do |month|
      month.strftime('%Y-%B')
    end
    form.zip(months.values).to_h
  end

  private
  def values
    [
      [60, :second],
      [60, :minute],
      [24, :hour]
    ]
  end


  def self.date_with_most_rides_result
    group(:end_date).order('count(end_date) DESC').limit(1).count(:id)
  end

  def self.date_with_least_rides_result
    group(:end_date).order('count(end_date)').limit(1).count(:id)
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
