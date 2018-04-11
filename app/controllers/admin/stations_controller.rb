class Admin::StationsController < Admin::BaseController
  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      flash[:success] = "#{@station.name} created!"
      redirect_to "/#{@station.slug}"
    else
      flash[:error] = 'Station not created!'
      render :new
    end
  end

  private

  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end
end
