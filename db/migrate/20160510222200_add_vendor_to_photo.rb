class AddVendorToPhoto < ActiveRecord::Migration
  def change
    add_reference :photos, :vendor, index: true, foreign_key: true
  end
end
