class MapLayer < ActiveRecord::Base
  attr_accessible :title, :icon, :hover_icon, :ancestry, :visible

  validates_presence_of :title

  has_many :placemarks, dependent: :destroy
  has_many :events, dependent: :destroy

  has_attached_file :icon, :storage => :elvfs, :elvfs_url => Settings['storage.url']
  has_attached_file :hover_icon, :storage => :elvfs, :elvfs_url => Settings['storage.url']

  has_ancestry

  normalize :ancestry do |value|
    value.blank? ? nil : value
  end

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  scope :visible, -> { where(visible: true) }

  def should_generate_new_friendly_id?
    return true if !self.slug?

    false
  end

  def ru_events
    children.events.where(:language => 'ru') rescue []
  end
end

# == Schema Information
#
# Table name: map_layers
#
#  id                      :integer          not null, primary key
#  title                   :string(255)
#  slug                    :string(255)
#  icon_file_name          :string(255)
#  icon_content_type       :string(255)
#  icon_file_size          :integer
#  icon_updated_at         :datetime
#  icon_url                :text
#  hover_icon_file_name    :string(255)
#  hover_icon_content_type :string(255)
#  hover_icon_file_size    :integer
#  hover_icon_updated_at   :datetime
#  hover_icon_url          :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  ancestry                :string(255)
#  position                :integer
#  visible                 :boolean
#
