class Event < ActiveRecord::Base
  attr_accessible :title, :document_type, :performer, :term_type, :start_year, :end_year,
                  :quarter, :state, :map_layer_id, :placemark_id, :language, :number

  delegate :title, to: :map_layer, prefix: true

  validate :correct_years
  validates_presence_of :title, :document_type, :performer, :state, :language

  normalize_attribute :title

  belongs_to :map_layer
  belongs_to :placemark

  has_many :document_events, dependent: :destroy
  has_many :documents, through: :document_events

  %w(implemented now postponed).each do |scope_part|
    scope scope_part.to_sym, -> { where(state: scope_part.to_sym) }
  end

  %w(ru en).each do |lang_part|
    scope lang_part.to_sym, -> { where(language: lang_part.to_sym) }
  end

  extend Enumerize
  enumerize :state,
            in: [:implemented, :now, :postponed],
            predicates: true

  enumerize :term_type,
            in: [:quarter, :period]

  enumerize :language,
            in: [:ru, :en]

  def correct_years
    errors.add(:end_year, 'Год начала не может быть больше года окончания') if term_type == 'period' && start_year && end_year && (start_year > end_year)
  end

  def filled_number
    number.presence || id
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
