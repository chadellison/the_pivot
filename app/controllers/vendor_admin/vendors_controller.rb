class VendorAdmin::VendorsController < ApplicationController
  def show
    @vendor = current_user.vendors.find(params[:id])
  end

  def update
    @vendor = current_user.vendors.find(params[:id])
    if @vendor.update(vendor_params)
      if params[:commit] == "Take Store Offline"
        flash[:success] = "Store Successfully Taken Offline"
      else
        flash[:success] = "Vendor Information Updated"
      end
      redirect_to dashboard_path(current_user.id)
    else
      flash[:error] = "Please try again."
      redirect_to vendor_admin_vendor_path(@vendor.id)
    end
  end

  private
    def vendor_params
      params.require(:vendor).permit(:name, :about, :status)
    end

end
