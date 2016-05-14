class AddReferencesToOrderPackages < ActiveRecord::Migration
  def change
    add_reference :order_packages, :photo, index: true, foreign_key: true
    add_reference :order_packages, :vendor, index: true, foreign_key: true
  end
end
