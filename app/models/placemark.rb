class Placemark < ActiveRecord::Base
  attr_accessible :title, :latitude, :longitude, :logotype

  belongs_to :map_layer
end
