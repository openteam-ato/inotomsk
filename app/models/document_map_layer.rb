class DocumentMapLayer < ActiveRecord::Base
  belongs_to :document
  belongs_to :map_layer
end
