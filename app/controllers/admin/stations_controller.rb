class Admin::StationsController < Admin::BaseController
  before_action :set_station, except: %i[new create]

  def edit
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

  def destroy
    if @station.destroy
      flash[:success] = 'Station Deleted!'
      redirect_to stations_path
    else
      flash[:error] = 'Station Not Deleted'
      redirect_to "/#{@station.slug}"
    end
  end

  private

  def station_params
    params.require(:station).permit(:name,
                                    :dock_count,
                                    :city,
                                    :installation_date)
  end

  def set_station
    @station = Station.friendly.find(params[:id])
  end
end
