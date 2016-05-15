class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :all_categories
  before_action :all_vendors
  before_action :set_cart
  before_action :authorize!
  helper_method :current_user

  def logged_in_user
    unless current_user
      render file: "/public/404"
    end
  end

  def current_permission
    @current_permission ||= Permissions.new(current_user,
                                                  params[:controller],
                                                  params[:action])
  end

  def authorize!
    unless current_permission.allow?
      render file: 'public/404.html'
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def all_categories
    @categories = Category.all
  end

  def all_vendors
    @vendors = Vendor.all
  end


  def set_cart
    @cart = Cart.new(session[:cart])
  end
end
