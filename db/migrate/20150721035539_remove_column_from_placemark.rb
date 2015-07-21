class RemoveColumnFromPlacemark < ActiveRecord::Migration
  def change
    remove_column :placemarks, :latitude, :longitude, :address
  end
end
