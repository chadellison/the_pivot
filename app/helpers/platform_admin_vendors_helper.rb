module PlatformAdminVendorsHelper
  def pending_vendors(vendors)
    vendors.where(status: "pending")
  end

  def inactive_vendors(vendors)
    vendors.where(status: "inactive")
  end
end
