class CreateVendorAdminsTable < ActiveRecord::Migration
  def change
    create_table :vendor_admins do |t|
      t.references :user, index: true, foreign_key: true
      t.references :vendor, index: true, foreign_key: true
    end
  end
end
