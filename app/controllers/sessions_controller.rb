class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if current_user.vendor?
        redirect_to vendor_dashboard_path
      else
        redirect_to photos_path
      end
    else
      flash[:alert] = "Incorrect email/password combination."
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
