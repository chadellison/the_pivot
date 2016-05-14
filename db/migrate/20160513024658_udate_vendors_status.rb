class UdateVendorsStatus < ActiveRecord::Migration
  def change
    change_table :vendors do |t|
      t.remove :status
      t.string :status, default: "Inactive"
    end
  end
end
