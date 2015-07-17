class Placemark < ActiveRecord::Base
  attr_accessible :title, :latitude, :longitude, :logotype, :address, :map_layer_id

  has_many :events, dependent: :destroy

  belongs_to :map_layer

  validates_presence_of :title, :map_layer
  validates_presence_of :latitude, :longitude, message: 'Укажите местоположение объекта на карте или введите его адрес'

  has_attached_file :logotype, :storage => :elvfs, :elvfs_url => Settings['storage.url']

  delegate :icon_url, to: :map_layer

  extend FriendlyId
  friendly_id :title, use: :slugged
end
