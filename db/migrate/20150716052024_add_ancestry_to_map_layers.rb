class AddAncestryToMapLayers < ActiveRecord::Migration
  def change
    add_column :map_layers, :ancestry, :string
    add_index :map_layers, :ancestry
  end
end
