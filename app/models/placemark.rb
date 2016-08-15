class Placemark < ActiveRecord::Base
  attr_accessible :title, :logotype, :map_layer_id, :address, :description, :number
  attr_accessor :address

  has_many :events,    dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :document_map_placemarks, dependent: :destroy
  has_many :documents, through: :document_map_placemarks

  belongs_to :map_layer

  accepts_nested_attributes_for :addresses

  validates_presence_of :title, :map_layer_id
  validates_presence_of :address, message: 'Укажите местоположение объекта на карте или введите его адрес'

  has_attached_file :logotype, storage: :elvfs, elvfs_url: Settings['storage.url']

  delegate :icon_url, to: :map_layer
  delegate :title, to: :map_layer, prefix: true

  normalize :title do |value|
    value.tr('"', "\'")
  end

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def filled_number
    number.presence || id
  end

  def full_title
    %(#{title} № #{filled_number})
  end
end

# == Schema Information
#
# Table name: placemarks
#
#  id                    :integer          not null, primary key
#  title                 :text
#  slug                  :text
#  logotype_file_name    :string(255)
#  logotype_content_type :string(255)
#  logotype_file_size    :integer
#  logotype_updated_at   :datetime
#  logotype_url          :text
#  map_layer_id          :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  description           :text
#
