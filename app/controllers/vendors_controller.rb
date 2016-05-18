class VendorsController < ApplicationController
  def show
    @vendor = Vendor.find_by(slug: params[:vendor])
    render file: "/public/404.html" unless @vendor
  end

  def index
    @vendors = Vendor.where(status: 1)
  end

  def new
    @vendor = Vendor.new
  end

  def create

    vendor = Vendor.new(vendor_params)
    if vendor.save
      role = Role.create(name: "vendor_admin")
      current_user.user_roles.create(user: current_user, vendor: vendor, role: role)
      flash["success"] = "Request for business sent"
      redirect_to dashboard_path(current_user.id)
    else
      flash.now["error"] = "Invalid field entry"
      render :new
    end
  end

  private

    def vendor_params
      params.require(:vendor).permit(:name, :about)
    end
end
