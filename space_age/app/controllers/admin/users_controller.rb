class Admin::UsersController < Admin::BaseController
  # before_action: require_login!, except: [:new, :creaet]
  def show
    @user = current_user
    @destination = Destination.new
    @package = Package.new
    @destinations = Destination.all
  end

end