class SessionsController < ApplicationController

  def create
    find_referrer
    @user = SessionsRouter.find_user(params[:session][:username])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to platform_admin_dashboard_path(current_user.id) and return if @user.platform_admin?
      redirect_to dashboard_path(current_user.id) and return if @user.vendor_admin?
      redirect_to dashboard_path(@user) and return if SessionsRouter.referer_login?(session[:return_to])
      redirect_to session.delete(:return_to) and return 
    else
      flash[:alert] = "Incorrect email/password combination."
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
