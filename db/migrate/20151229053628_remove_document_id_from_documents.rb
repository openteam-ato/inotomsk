class RemoveDocumentIdFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :document_id, :integer
  end
end
