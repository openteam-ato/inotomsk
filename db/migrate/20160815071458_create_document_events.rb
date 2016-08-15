class CreateDocumentEvents < ActiveRecord::Migration
  def change
    create_table :document_events do |t|
      t.belongs_to :document
      t.belongs_to :event

      t.timestamps null: false
    end
  end
end
