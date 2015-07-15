class CreatePlacemarks < ActiveRecord::Migration
  def change
    create_table :placemarks do |t|
      t.string :title
      t.string :slug
      t.string :address
      t.float :latitude
      t.float :longitude
      t.attachment :logotype
      t.belongs_to :map_layer
      t.timestamps
    end
  end
end
