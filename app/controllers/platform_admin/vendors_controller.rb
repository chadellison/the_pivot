class PlatformAdmin::VendorsController < ApplicationController
  def index
    @vendors = Vendor.all
  end

  def destroy
    vendor = Vendor.find(params[:id])
    # vendor.photos.each do |photo|
    #   Photo.delete(photo)
    # end
    vendor.photos.destroy_all
    vendor.destroy
    flash[:success] = "#{vendor.name} was successfully removed!"
    redirect_to platform_admin_vendors_path
  end
end
