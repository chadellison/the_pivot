class AddRoleToVendorAdmins < ActiveRecord::Migration
  def change
    add_reference :vendor_admins, :role, index: true, foreign_key: true
  end
end
