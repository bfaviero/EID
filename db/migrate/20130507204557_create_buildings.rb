class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :mit
      t.string :name

      t.timestamps
    end
  end
end
