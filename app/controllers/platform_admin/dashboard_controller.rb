class PlatformAdmin::DashboardController < ApplicationController
  def show
    @vendors = Vendor.all
  end
end
