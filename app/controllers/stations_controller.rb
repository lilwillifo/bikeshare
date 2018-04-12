class StationsController < ApplicationController

  def index
    @stations = Station.all
  end

  def show
    # require 'pry'; binding.pry
    @station = Station.find_by(params[:slug])
  end
end
