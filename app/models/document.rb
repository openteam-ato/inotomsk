class Document < ActiveRecord::Base

  attr_accessor :delete_file

  attr_accessible :title, :date_on, :kind, :tags, :file, :tag_list, :delete_file

  has_many :documents

  validates_presence_of :title, :date_on, :kind, :file

  acts_as_taggable

  extend Enumerize

  enumerize :kind, in: [
    :disposal,    # распоряжение
    :assignment,  # поручение
    :order,       # приказ
    :report,      # отчет
    :letter       # письмо
  ], :prefix => true

  has_attached_file :file, {
    path: ':rails_root/files/:class/:id_partition/:filename',
    url: '/files/:id/download',
    preserve_files: true,
  }
  validates_attachment_presence :file
  do_not_validate_attachment_file_type :file
  before_post_process :rename_file
  validates_uniqueness_of :file_fingerprint, message: 'Данный файл уже был загружен ранее'

  private

  def rename_file
    filename = Russian.translit(File.basename(file_file_name, '.*').mb_chars.downcase).parameterize('-').gsub('_', '-')
    extension = Russian.translit(File.extname(file_file_name).mb_chars.downcase).parameterize('-')
    self.file.instance_write :file_name, "#{filename.capitalize}.#{extension}"
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
#  document_id       :integer
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  file_url          :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_fingerprint  :string
#
