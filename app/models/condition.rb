class Condition < ApplicationRecord
  validates_presence_of :date,
                        :max_temperature,
                        :mean_temperature,
                        :min_temperature,
                        :mean_humidity,
                        :mean_visibility,
                        :mean_wind_speed,
                        :precipitation

  has_many :trips, dependent: :destroy

  def self.temp_ranges(range)
    joins(:trips)
    .where("max_temperature >= #{range[0]} AND max_temperature <= #{range[1]}")
    .group(:condition_id)
    .count(:condition_id)
    .values
  end

  def self.most_rides_by_temp(range)
    temp_ranges(range).max
  end

  def self.least_rides_by_temp(range)
    temp_ranges(range).min
  end

  def self.average_rides_by_temp(range)
    return 0 if temp_ranges(range).empty?
    (temp_ranges(range).sum / temp_ranges(range).count.to_f).round(2)
  end

  def self.precipitation_ranges(range)
    joins(:trips)
    .where("precipitation >= #{range[0]} AND precipitation <= #{range[1]}")
    .group(:condition_id)
    .count(:condition_id)
    .values
  end

  def self.most_rides_by_rain(range)
    precipitation_ranges(range).max
  end

  def self.least_rides_by_rain(range)
    precipitation_ranges(range).min
  end

  def self.average_rides_by_rain(range)
    return 0 if precipitation_ranges(range).empty?
    (precipitation_ranges(range).sum / precipitation_ranges(range).count.to_f).round(2)
  end

  def self.wind_ranges(range)
    joins(:trips)
    .where("mean_wind_speed >= #{range[0]} AND mean_wind_speed <= #{range[1]}")
    .group(:condition_id)
    .count(:condition_id)
    .values
  end

  def self.most_rides_by_wind(range)
    wind_ranges(range).max
  end

  def self.least_rides_by_wind(range)
    wind_ranges(range).min
  end

  def self.average_rides_by_wind(range)
    return 0 if wind_ranges(range).empty?
    (wind_ranges(range).sum / wind_ranges(range).count.to_f).round(2)
  end

  def self.visibility_ranges(range)
    joins(:trips)
    .where("mean_visibility >= #{range[0]} AND mean_visibility <= #{range[1]}")
    .group(:condition_id)
    .count(:condition_id)
    .values
  end

  def self.most_rides_by_visibility(range)
    visibility_ranges(range).max
  end

  def self.least_rides_by_visibility(range)
    visibility_ranges(range).min
  end

  def self.average_rides_by_visibility(range)
    return 0 if visibility_ranges(range).empty?
    (visibility_ranges(range).sum / visibility_ranges(range).count.to_f).round(2)
  end
end
