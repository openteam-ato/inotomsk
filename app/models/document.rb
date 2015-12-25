class Document < ActiveRecord::Base

  attr_accessible :title, :date_on, :kind, :tags, :file

  acts_as_taggable

  extend Enumerize

  enumerize :document_type, :in => [
    :disposal,    # распоряжение
    :assignment,  # поручение
    :order,       # приказ
    :report,      # отчет
    :letter       # письмо
  ], :prefix => true

  has_attached_file :file, {
    :url => '/files/:hash.:extension',
    :hash_secret => Settings['app.secret'],
    :preserve_files => 'true',
  }
  validates_attachment_presence :file
  do_not_validate_attachment_file_type :file

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
