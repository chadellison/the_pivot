class PlatformAdmin::VendorsController < ApplicationController
  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    if params[:pending]
      vendor = Vendor.find(params[:id])
      vendor.update(status: params[:pending])
      flash[:success] = "#{vendor.name} has been approved" if params[:pending] == "active"
    else
      vendor = Vendor.find(params[:id])
      vendor.update(vendor_params)
      flash[:success] = "#{Vendor.find(vendor.id).name} has been updated."
    end
    redirect_to platform_admin_dashboard_path
  end

  def destroy
    vendor = Vendor.find(params[:id])
    vendor.photos.destroy_all
    vendor.destroy
    flash[:success] = "#{vendor.name} was successfully removed!"
    redirect_to platform_admin_dashboard_path
  end

  private

    def vendor_params
      params.require(:vendor).permit(:name, :about, :status)
    end
end
