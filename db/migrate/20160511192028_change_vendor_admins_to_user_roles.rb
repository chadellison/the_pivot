class ChangeVendorAdminsToUserRoles < ActiveRecord::Migration
  def change
    rename_table :vendor_admins, :user_roles
  end
end
