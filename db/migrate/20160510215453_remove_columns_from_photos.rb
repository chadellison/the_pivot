class RemoveColumnsFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :destination_id, :status
  end
end
