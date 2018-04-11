class Admin::TripsController < Admin::BaseController
  before_action :set_trip, only: %i[edit update destroy]

  def edit
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      flash[:success] = "Trip: #{@trip.id} Created!"
      redirect_to trip_path(@trip)
    else
      flash[:error] = 'Trip Not Created!'
      render :new
    end
  end

  def update
    @trip.update(trip_params)
    if @trip.save
      flash[:success] = "Trip: #{@trip.id} Updated!"
      redirect_to trip_path(@trip)
    else
      flash[:error] = 'Trip Not Updated!'
      render :edit
    end
  end

  def destroy
    if @trip.destroy
      flash[:success] = 'Trip Deleted!'
      redirect_to trips_path
    else
      flash[:error] = 'Trip Not Deleted!'
      redirect_to trip_path(@trip)
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:duration, :start_date, :end_date, :bike_id, :subscription_type, :zip_code, :start_station_id, :end_station_id)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
