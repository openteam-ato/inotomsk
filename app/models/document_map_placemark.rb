class DocumentMapPlacemark < ActiveRecord::Base
  belongs_to :document
  belongs_to :placemark
end
