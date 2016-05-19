class DropDestinationsTable < ActiveRecord::Migration
  def change
    drop_table :destinations
  end
end
