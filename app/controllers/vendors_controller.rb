class VendorsController < ApplicationController
  def show
    @vendor = Vendor.find_by(slug: params[:vendor])
    render file: "/public/404.html" unless @vendor
  end

  def index
    byebug
  end
end
