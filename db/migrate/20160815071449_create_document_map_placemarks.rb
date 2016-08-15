class CreateDocumentMapPlacemarks < ActiveRecord::Migration
  def change
    create_table :document_map_placemarks do |t|
      t.belongs_to :document
      t.belongs_to :placemark

      t.timestamps null: false
    end
  end
end
