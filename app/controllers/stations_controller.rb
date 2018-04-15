class StationsController < ApplicationController

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
  end
end
