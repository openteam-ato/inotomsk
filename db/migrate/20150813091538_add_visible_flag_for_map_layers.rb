class AddVisibleFlagForMapLayers < ActiveRecord::Migration
  def change
    add_column :map_layers, :visible, :boolean

    MapLayer.update_all(:visible => true)
  end
end
