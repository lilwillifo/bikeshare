class StationsController < ApplicationController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.find_by(slug: params[:name])
  end

  def dashboard
    @num_stations = Station.count
    @avg_bikes = Station.average_bikes
  end
end
