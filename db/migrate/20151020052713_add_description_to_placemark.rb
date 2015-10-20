class AddDescriptionToPlacemark < ActiveRecord::Migration
  def change
    add_column :placemarks, :description, :text
  end
end
