class Admin::ConditionsController < Admin::BaseController
  before_action :set_condition, only: %i[edit update destroy]

  def edit
  end

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(condition_params)
    if @condition.save
      flash[:success] = "Weather condition for #{(@condition.date).strftime('%m %d %Y')} added!"
      redirect_to condition_path(@condition)
    else
      flash[:error] = 'Condition Not Created!'
      render :new
    end
  end

  def update
    if @condition.update(condition_params)
      flash[:success] =  "Weather conditions for #{(@condition.date).strftime('%m %d %Y')} updated!"
      redirect_to condition_path(@condition)
    else
      flash[:error] = "Weather conditions for #{date} not updated!"
      render :edit
    end
  end

  def destroy
    date = @condition.date.strftime('%m %d %Y')
    if @condition.destroy
      flash[:success] = "Weather condition for #{date} deleted!"
      redirect_to conditions_path
    else
      flash[:error] = "Weather condition for #{date} not deleted!"
      redirect_to condition_path(@condition)
    end
  end

  private
  
  def condition_params
    params.require(:condition).permit(:date,
                                      :max_temperature,
                                      :mean_temperature,
                                      :min_temperature,
                                      :mean_humidity,
                                      :mean_visibility,
                                      :mean_wind_speed,
                                      :precipitation)
  end

  def set_condition
    @condition = Condition.find(params[:id])
  end
end
