class RenameTableOrderPackagesToOrderPhotos < ActiveRecord::Migration
  def change
    rename_table :order_packages, :order_photos
  end
end
