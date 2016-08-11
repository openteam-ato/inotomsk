class CreateUserMapLayers < ActiveRecord::Migration
  def change
    create_table :user_map_layers do |t|
      t.belongs_to :user
      t.string :map_layer

      t.timestamps null: false
    end
  end
end
