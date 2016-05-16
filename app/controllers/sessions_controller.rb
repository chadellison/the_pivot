class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if @user.platform_admin?
        redirect_to platform_admin_dashboard_path(current_user.id)
      else
        redirect_to dashboard_path(current_user.id)
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
