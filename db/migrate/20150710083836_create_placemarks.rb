class CreatePlacemarks < ActiveRecord::Migration
  def change
    create_table :placemarks do |t|
      t.string :title
      t.float :latitude
      t.float :longitude
      t.attachment :logotype
      t.belongs_to :map_layer
      t.timestamps
    end
  end
end
