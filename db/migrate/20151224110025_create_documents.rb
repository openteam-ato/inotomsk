class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string     :title
      t.date       :date_on
      t.text       :tags
      t.string     :document_type
      t.belongs_to :document
      t.attachment :file

      t.timestamps null: false
    end
  end
end
