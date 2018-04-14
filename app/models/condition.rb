class Condition < ApplicationRecord
  validates_presence_of :date,
                        :max_temperature,
                        :mean_temperature,
                        :min_temperature,
                        :mean_humidity,
                        :mean_visibility,
                        :mean_wind_speed,
                        :precipitation

  has_many :trips

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
    temp_ranges(range).sum / temp_ranges(range).count.to_f
  end
end
