class PlatformAdmin::VendorsController < ApplicationController
  def index
    @vendors = Vendor.all
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    vendor = Vendor.find(params[:id])
    vendor.update(vendor_params)
    flash[:success] = "#{Vendor.find(vendor.id).name} has been updated."
    redirect_to platform_admin_vendors_path
  end

  def destroy
    vendor = Vendor.find(params[:id])
    vendor.photos.destroy_all
    vendor.destroy
    flash[:success] = "#{vendor.name} was successfully removed!"
    redirect_to platform_admin_vendors_path
  end

  private

    def vendor_params
      params.require(:vendor).permit(:name, :about, :status)
    end
end
