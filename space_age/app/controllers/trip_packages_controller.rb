class TripPackagesController < ApplicationController

  include TripPackagesHelper

  def create
    package = Package.find(params[:package_id])
    @trip.add_package(package.id)

    session[:trip] = @trip.itinerary
    flash[:notice] = "You have added #{package.title} to your trip. Your current trip costs: #{@trip.total_price}."
    redirect_to package_path(package)
  end

   def show
    unless @trip.itinerary.nil?
      @packages = @trip.itinerary.keys.map do |id|
        Package.find(id)
      end
    end
  end

  def update
    @trip.adjust_quantity(params[:operation], params[:id])
    redirect_to '/trip'
  end


  def destroy
    package = Package.find(params[:id])
    @trip.itinerary.delete(params[:id])
    flash[:delete_package] = "Successfully removed #{package.title} from your trip"
    redirect_to "/trip"
  end

end
