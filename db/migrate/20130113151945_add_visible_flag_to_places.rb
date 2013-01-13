class AddVisibleFlagToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :visible, :boolean, :default => false
  end
end
