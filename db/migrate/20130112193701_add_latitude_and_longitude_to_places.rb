class AddLatitudeAndLongitudeToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :latitude, :float
    add_column :places, :longitude, :float
    add_column :places, :gmaps, :boolean
  end
end
