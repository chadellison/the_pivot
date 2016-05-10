class VendorsController < ApplicationController
  def show
    @vendor = Vendor.find_by(slug: params[:vendor])
  end
end
