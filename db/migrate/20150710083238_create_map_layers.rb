class CreateMapLayers < ActiveRecord::Migration
  def change
    create_table :map_layers do |t|
      t.string :title
      t.string :slug
      t.attachment :icon
      t.attachment :hover_icon
      t.timestamps
    end
  end
end
