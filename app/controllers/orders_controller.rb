class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def index
    @orders = current_user.orders
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
