class Admin::TripsController < Admin::BaseController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      flash[:success] = 'Trip Created!'
      redirect_to trip_path(@trip)
    else
      flash[:error] = 'Trip Not Created!'
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:duration, :start_date, :end_date, :bike_id, :subscription_type, :zip_code, :start_station_id, :end_station_id)
  end
end
