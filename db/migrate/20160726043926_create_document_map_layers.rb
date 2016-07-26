class CreateDocumentMapLayers < ActiveRecord::Migration
  def change
    create_table :document_map_layers do |t|
      t.belongs_to :document
      t.belongs_to :map_layer

      t.timestamps null: false
    end
  end
end
