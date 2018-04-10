class AddSlugToStations < ActiveRecord::Migration[5.1]
  def change
    add_column :stations, :slug, :name
    add_index :stations, :slug, unique: true
  end
end
