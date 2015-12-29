class CreateRelatedDocuments < ActiveRecord::Migration
  def change
    create_table :related_documents do |t|
      t.integer :document_id
      t.integer :related_document_id

      t.timestamps null: false
    end
  end
end
