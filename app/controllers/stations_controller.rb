class StationsController < ApplicationController
  before_action :require_login
  
  def index
    @stations = Station.all
  end

  def show
    @station = Station.find_by(slug: params[:name])
  end

  def dashboard
    @num_stations = Station.count
    @avg_bikes = Station.avg_bikes
    @max_bikes = Station.max_bike_count
    @max_bikes_stations = Station.max_bikes

    @min_bikes = Station.min_bike_count
    @min_bikes_stations = Station.min_bikes

    @newest_station = Station.newest
    @oldest_station = Station.oldest
  end
end
