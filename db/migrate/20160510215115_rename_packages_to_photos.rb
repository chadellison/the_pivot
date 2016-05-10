class RenamePackagesToPhotos < ActiveRecord::Migration
  def change
    rename_table :packages, :photos
  end
end
