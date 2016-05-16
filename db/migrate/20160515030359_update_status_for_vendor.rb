class UpdateStatusForVendor < ActiveRecord::Migration
  def change
    change_table :vendors do |t|
      t.remove :status
      t.integer :status, default: 0
    end
  end
end
