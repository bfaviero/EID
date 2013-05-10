class RemoveCreatedAtAndRemoveAtFromBuildings < ActiveRecord::Migration
  def change
    remove_column :buildings, :created_at
    remove_column :buildings, :updated_at
    remove_column :routes, :created_at
    remove_column :routes, :updated_at
    remove_column :stops, :created_at
    remove_column :stops, :updated_at
  end

end
