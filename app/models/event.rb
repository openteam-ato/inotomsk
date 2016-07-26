class Event < ActiveRecord::Base
  attr_accessible :title, :document_type, :performer, :term_type, :start_year, :end_year,
                  :quarter, :state, :map_layer_id, :placemark_id, :language

  delegate :title, to: :map_layer, prefix: true

  validate :correct_years
  validates_presence_of :title, :document_type, :performer, :state, :language

  belongs_to :map_layer
  belongs_to :placemark

  scope :implemented, -> { where(state: :implemented) }
  scope :now,         -> { where(state: :now) }
  scope :postponed,   -> { where(state: :postponed) }

  scope :ru, -> { where(language: :ru) }
  scope :en, -> { where(language: :en) }

  extend Enumerize
  enumerize :state,
            in: [:implemented, :now, :postponed],
            predicates: true

  enumerize :term_type,
            in: [:quarter, :period]

  enumerize :language,
            in: [:ru, :en]

  def correct_years
    if term_type == 'period' && (start_year > end_year)
      errors.add(:end_year, 'Год начала не может быть больше года окончания')
    end
  end
end

# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  title         :text
#  document_type :text
#  performer     :text
#  term_type     :string(255)
#  start_year    :integer
#  end_year      :integer
#  quarter       :string(255)
#  state         :string(255)
#  map_layer_id  :integer
#  placemark_id  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  language      :string(255)
#
