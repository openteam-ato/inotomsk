class Document < ActiveRecord::Base
  attr_accessible :title, :date_on, :number, :kind, :tags, :file, :tag_list, :annotation,
                  :related_documents_attributes, :map_layer_ids, :event_ids, :placemark_ids,
                  :participants, :participant_list

  has_many :related_documents,   dependent: :destroy
  has_many :documents, dependent: :destroy, foreign_key: 'related_document_id', class_name: 'RelatedDocument'
  has_many :document_map_layers, dependent: :destroy
  has_many :children, through: :related_documents, class_name: 'Document'
  has_many :document_map_placemarks, dependent: :destroy
  has_many :document_events, dependent: :destroy

  has_many :parents, through: :documents, class_name: 'Document'
  has_many :map_layers, through: :document_map_layers
  has_many :placemarks, through: :document_map_placemarks
  has_many :events, through: :document_events

  scope :ordered, -> { order(date_on: :desc) }

  accepts_nested_attributes_for :related_documents, allow_destroy: true

  validates_presence_of :title, :date_on, :kind, :file

  acts_as_taggable_on :tags, :participants

  after_create :notify_users

  extend Enumerize

  enumerize :kind, in: [
    :rept,                   # доклад
    :report,                 # отчет
    :letter,                 # письмо
    :agenda,                 # повестка
    :assignment,             # поручение
    :decree_by_government,   # постановление Правительства Российской Федерации
    :order,                  # приказ
    :protocol,               # протокол
    :disposal_by_deputy,     # распоряжение Губернатора Томской области
    :disposal_by_government, # распоряжение Правительства Российской Федерации
    :approved_by_deputy,     # утвержден заместителем Губернатора Томской области
  ], prefix: true

  normalize :title, :number

  has_attached_file :file, path: ':rails_root/files/:class/:id_partition/:filename',
                           url: '/files/:id/download',
                           preserve_files: true
  validates_attachment_presence :file
  do_not_validate_attachment_file_type :file
  before_post_process :rename_file
  validates_uniqueness_of :file_fingerprint, message: 'Данный файл уже был загружен ранее'

  def related_documents_objects
    related_documents.includes(:documents)
  end

  def full_title
    [
      title,
      'от',
      I18n.l(date_on),
      %(№#{number})
    ].join(' ')
  end

  def notify_users
    users = UserTag.where(tag: tag_list).map(&:user)
    users << UserMapLayer.where(map_layer: map_layers.pluck(:title)).map(&:user)

    users.flatten.uniq.each do |user|
      DocumentsMailer.send_notify(user, self).deliver_later
    end
  end

  private

  def rename_file
    filename = Russian.translit(File.basename(file_file_name, '.*').mb_chars.downcase).parameterize('-').tr('_', '-')
    extension = Russian.translit(File.extname(file_file_name).mb_chars.downcase).parameterize('-')
    file.instance_write :file_name, "#{filename.capitalize}.#{extension}"
  end
end

# == Schema Information
#
# Table name: documents
#
#  id                :integer          not null, primary key
#  title             :string
#  date_on           :date
#  tags              :text
#  kind              :string
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  file_url          :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_fingerprint  :string
#  number            :string
#  annotation        :text
#  participants      :text
#
