class ChangeOrderPackages < ActiveRecord::Migration
  def change
    remove_column :order_packages, :user_id
    remove_column :order_packages, :package_id
  end
end
