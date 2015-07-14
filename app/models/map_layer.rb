class MapLayer < ActiveRecord::Base
   attr_accessible :title, :icon, :hover_icon

   validates_presence_of :title
   has_many :placemarks, dependent: :destroy

   has_attached_file :icon, :storage => :elvfs, :elvfs_url => Settings['storage.url']
   has_attached_file :hover_icon, :storage => :elvfs, :elvfs_url => Settings['storage.url']

   extend FriendlyId
   friendly_id :title, use: :slugged
end
