class AddAnnotationAndParticipantsToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :annotation, :text
    add_column :documents, :participants, :text
  end
end
