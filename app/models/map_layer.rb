class MapLayer < ActiveRecord::Base
   attr_accessible :title, :icon, :hover_icon

   has_many :placemarks

   extend FriendlyId
   friendly_id :title, use: :slugged
end
