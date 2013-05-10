class ChangeStop < ActiveRecord::Migration
  def up
    change_column :stops, :nid, :string
  end

  def down
  end
end
