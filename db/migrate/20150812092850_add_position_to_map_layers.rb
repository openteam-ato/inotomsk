class AddPositionToMapLayers < ActiveRecord::Migration
  def change
    add_column :map_layers, :position, :integer
  end
end
