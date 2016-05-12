class AddAboutToVendor < ActiveRecord::Migration
  def change
    add_column :vendors, :about, :string
  end
end
