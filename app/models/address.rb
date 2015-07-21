class Address < ActiveRecord::Base
   attr_accessible :latitude, :longitude

   belongs_to :placemark
end
