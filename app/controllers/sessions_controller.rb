class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if current_admin?
        flash[:success] = "Logged in as Admin User: #{user.username}"
        redirect_to admin_dashboard_path
      else
        flash[:success] = "Logged in as #{user.username}"
        redirect_to '/dashboard'
      end
    else
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = 'Successfully logged out!'
    redirect_to '/'
  end
end
