class AddCostToOrderPackages < ActiveRecord::Migration
  def change
    add_column :order_photos, :cost, :float
  end
end
