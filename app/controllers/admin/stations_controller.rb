class Admin::StationsController < Admin::BaseController
  before_action :set_station, except: [:new, :create]

  def edit
    # @station = Station.friendly.find(params[:name])
  end

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

  def update
    @station.slug = nil
    @station.update(station_params)
    if @station.save
      flash[:success] = "#{@station.name} updated!"
      redirect_to "/#{@station.slug}"
    else
      flash[:error] = 'Station not updated!'
      render :edit
    end
  end

  private

  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end

  def set_station
    @station = Station.friendly.find(params[:id])
  end
end
