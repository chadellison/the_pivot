class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]

  def index
   @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params_check)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      redirect_to login_path
    end
  end

  def update
    if current_user.update_attributes(params_check)
      flash[:success] = "Success! Your account updated."
    else
      flash[:error] = "Your account could not be updated. Please check your input and try again."
    end
      redirect_to  dashboard_path
  end

  def show
    
  end

  private

  def params_check
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
