class AddStatusToVendor < ActiveRecord::Migration
  def change
    add_column :vendors, :status, :string, default: "inactive"
  end
end
