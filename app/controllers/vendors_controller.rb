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
      current_user.user_roles.create(vendor: vendor, role: Role.find_by(name: "vendor_admin"))
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
