class AddAncestryDepthToMapLayer < ActiveRecord::Migration
  def change
    add_column :map_layers, :ancestry_depth, :integer, default:  0
  end
end
