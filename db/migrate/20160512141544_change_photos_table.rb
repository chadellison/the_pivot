class ChangePhotosTable < ActiveRecord::Migration
  def change
    change_table :photos do |t|
      t.remove :price
      t.integer :price
    end
  end
end
