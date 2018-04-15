class TripsController < ApplicationController
  before_action :require_login, only: [:dashboard]

  def index
    @trips = Trip.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def dashboard
    @trips = Trip.all
  end
end
