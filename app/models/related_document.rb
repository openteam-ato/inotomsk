class RelatedDocument < ActiveRecord::Base
  attr_accessor :related_document_title
  attr_accessible :document_id, :related_document_id, :related_document_title

  belongs_to :child,  foreign_key: :related_document_id, class_name: 'Document'
  belongs_to :parent, foreign_key: :document_id, class_name: 'Document'

  validates :related_document_id, uniqueness: { scope: :document_id }
end

# == Schema Information
#
# Table name: related_documents
#
#  id                  :integer          not null, primary key
#  document_id         :integer
#  related_document_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
