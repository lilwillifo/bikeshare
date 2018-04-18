class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.integer :duration
      t.datetime :start_date
      t.datetime :end_date
      t.integer :bike_id
      t.integer :subscription_type, default: 0
      t.integer :zip_code
      t.integer :start_station_id
      t.integer :end_station_id

      t.timestamps
    end
  end
end
