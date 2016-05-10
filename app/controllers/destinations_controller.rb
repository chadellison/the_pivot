class DestinationsController < ApplicationController

  def show
    @destination = Destination.find_by(planet: params[:planet])
    render file: "/public/404" unless @destination
  end

end
