class PendingController < ApplicationController
  def index
    @vendors = Vendor.where(status: "pending")
  end
end
