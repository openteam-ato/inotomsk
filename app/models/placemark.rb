class Placemark < ActiveRecord::Base
  attr_accessible :title, :logotype, :map_layer_id, :address
  attr_accessor :address

  has_many :events,    dependent: :destroy
  has_many :addresses, dependent: :destroy

  belongs_to :map_layer

  accepts_nested_attributes_for :addresses

  validates_presence_of :title, :map_layer_id
  validates_presence_of :address, message: 'Укажите местоположение объекта на карте или введите его адрес'

  has_attached_file :logotype, :storage => :elvfs, :elvfs_url => Settings['storage.url']

  delegate :icon_url, to: :map_layer

  extend FriendlyId
  friendly_id :title, use: :slugged
end
