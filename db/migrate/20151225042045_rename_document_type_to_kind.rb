class RenameDocumentTypeToKind < ActiveRecord::Migration
  def change
    rename_column :documents, :document_type, :kind
  end
end
