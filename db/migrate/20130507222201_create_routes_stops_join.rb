class CreateRoutesStopsJoin < ActiveRecord::Migration
  def up
    create_table 'routes_stops', :id => false do |t|
      t.column 'route_id', :integer
      t.column 'stop_id', :integer
    end
  end

  def down
  end
end
