require 'test_helper'

class RelatedDocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
