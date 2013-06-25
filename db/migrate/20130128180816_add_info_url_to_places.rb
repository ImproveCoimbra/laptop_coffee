class AddInfoUrlToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :info_url, :string
  end
end
