class AddStickersToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :sticker, :int
  end
end
