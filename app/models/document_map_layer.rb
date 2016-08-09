class DocumentMapLayer < ActiveRecord::Base
  belongs_to :document
  belongs_to :map_layer
end

# == Schema Information
#
# Table name: document_map_layers
#
#  id           :integer          not null, primary key
#  document_id  :integer
#  map_layer_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
