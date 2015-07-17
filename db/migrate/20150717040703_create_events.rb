class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :title
      t.text :document_type
      t.text :performer
      t.string :term_type
      t.integer :start_year
      t.integer :end_year
      t.string :quarter
      t.string :state
      t.belongs_to :map_layer
      t.belongs_to :placemark
      t.timestamps
    end
  end
end
