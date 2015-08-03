class Event < ActiveRecord::Base
  attr_accessible :title, :document_type, :performer, :term_type, :start_year, :end_year,
                  :quarter, :state, :map_layer_id, :placemark_id

  validate :correct_years
  validates_presence_of :title, :document_type, :performer, :state

  belongs_to :map_layer
  belongs_to :placemark

  scope :implemented, -> {where(state: :implemented)}
  scope :now, -> {where(state: :now)}
  scope :postponed, -> {where(state: :postponed)}

  extend Enumerize
  enumerize :state,
    in: [:implemented, :now, :postponed],
    predicates: true

  enumerize :term_type,
    in: [:quarter, :period]

  def correct_years
    if term_type == 'period' && (start_year > end_year)
      errors.add(:end_year, "Год начала не может быть больше года окончания")
    end
  end
end
