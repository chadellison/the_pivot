class PlatformAdmin::VendorsController < ApplicationController
  def index
    @vendors = Vendor.all
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    if params[:pending]
      vendor = Vendor.find(params[:id])
      vendor.update(status: params[:pending])
      vendor.users.last.roles.create(name: "vendor_admin")
      flash[:success] = "#{vendor.name} has been approved" if params[:pending] == "active"
      redirect_to pending_path
    else
      vendor = Vendor.find(params[:id])
      vendor.update(vendor_params)
      flash[:success] = "#{Vendor.find(vendor.id).name} has been updated."
      redirect_to platform_admin_vendors_path
    end
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
