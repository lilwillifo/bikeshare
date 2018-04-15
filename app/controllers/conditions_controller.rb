class ConditionsController < ApplicationController
  before_action :set_condition, only: [:show]
  before_action :require_login, only: [:dashboard]

  def index
    @conditions = Condition.all
  end

  def show
  end

  def dashboard
    @temp_ranges = [[50,59.9],[60,69.9],[70,79.9],[80,89.9]]
    @rain_ranges = [[0, 0.5], [0.5, 1], [1, 1.5], [1.5, 2], [2, 2.5]]
    @conditions = Condition.all
  end

  private

  def set_condition
    @condition = Condition.find(params[:id])
  end
end
