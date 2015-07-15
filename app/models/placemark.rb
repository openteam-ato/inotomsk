class Placemark < ActiveRecord::Base
  attr_accessible :title, :latitude, :longitude, :logotype, :address, :map_layer_id

  belongs_to :map_layer

  validates_presence_of :title, :map_layer
  validates_presence_of :latitude, :longitude, message: 'Укажите местоположение объекта на карте или введите его адрес'

  has_attached_file :logotype, :storage => :elvfs, :elvfs_url => Settings['storage.url']

  extend FriendlyId
  friendly_id :title, use: :slugged
end
