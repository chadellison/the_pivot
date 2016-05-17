module PlatformAdminVendorsHelper
  def pending_vendors(vendors)
    vendors.where(status: 0)
  end

  def inactive_vendors(vendors)
    vendors.where(status: 2)
  end

  def active_vendors(vendors)
    vendors.where(status: 1)
  end
end
