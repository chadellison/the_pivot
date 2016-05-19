class PlatformAdmin::VendorsController < ApplicationController
  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    if params[:pending]
      vendor = Vendor.find(params[:id])
      vendor.update(status: params[:pending])
      flash[:success] = "#{vendor.name} has been approved" if params[:pending] == "active"
      flash[:success] = "#{vendor.name} has been taken offline" if params[:pending] == "inactive"
    else
      vendor = Vendor.find(params[:id])
      vendor.update(vendor_params)
      flash[:success] = "#{Vendor.find(vendor.id).name} has been updated."
    end
    redirect_to platform_admin_dashboard_path
  end

  private

    def vendor_params
      params.require(:vendor).permit(:name, :about, :status, :logo)
    end
end
