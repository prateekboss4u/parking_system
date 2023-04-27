class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.integer :two_wheeler_capacity
      t.integer :four_wheeler_capacity
      t.integer :commercial_vehicle_capacity

      t.timestamps
    end
  end
end
