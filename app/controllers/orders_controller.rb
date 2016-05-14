class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def show
    @order = current_user.orders.find(params[:id])
  end

  def index
    @orders = current_user.orders
  end

  def download
    photo = Photo.find(params[:photo])
    send_file photo.image.path, type: "image/jpeg"
  end

  def create
    new_order = OrderGenerator.new(current_user, @cart)
    if new_order
      flash[:success] = "Order was Successfully Placed"
      session[:cart].clear
      redirect_to orders_path
    else
      redirect_to "/cart"
    end
  end

end
