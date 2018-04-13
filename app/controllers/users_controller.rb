class UsersController < ApplicationController
  before_action :require_login, only: :dashboard

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.username}"
      redirect_to '/dashboard'
    else
      redirect_to new_user_path
    end
  end

  def dashboard
  end

  def edit
    @user = current_user
  end

  def update
    if @user = current_user
      @user.update(user_params)
      flash[:success] = "#{@user.username}, your account has been updated!"
      redirect_to dashboard_path
    else
      flash[:error] = "#{@user.username}, your account didn't update."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
