class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]

  def edit
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    if params[:commit] == "Create Admin"
      user = User.create(params_check)
      admin_creator(user, user.save)
    elsif params[:commit] == "Add Admin"
      user = User.find_by(username: params[:user][:username])
      admin_creator(user, user)
    else
      user_creator
    end
  end

  def update
    if current_user.update_attributes(params_check)
      flash[:success] = "Success! Your account updated."
      redirect_to dashboard_path(current_user)
    else
      flash[:error] = "Your account could not be updated. Please check your input and try again."
      redirect_to edit_profile_path
    end
  end

  def show
    @photo = Photo.new
  end

  private
    def params_check
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def admin_creator(user, condition)
      vendor = current_user.vendors.find(params[:user][:vendor_ids])
      role = Role.find_by(name: "vendor_admin")
      if condition
        vendor.user_roles.create(role: role, user: user)
        flash[:success] = "Admin successfully created."
        redirect_to dashboard_path(current_user)
      else
        flash[:error] = "Your admin could not be created. Please check your input and try again."
        redirect_to dashboard_path(current_user)
      end
    end

    def user_creator
      @user = User.create(params_check)
      if @user.save
        role =  Role.new_customer
        @user.roles << role
        session[:user_id] = @user.id
        flash[:success] = "Success! Your account was created!."
        redirect_to dashboard_path(current_user)
      else
        flash[:error] = "Your account could not be created. Please check your input and try again."
        redirect_to users_path
      end
    end
end
