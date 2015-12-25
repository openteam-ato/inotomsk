class Document < ActiveRecord::Base
  extend Enumerize

  enumerize :document_type, :in => [:disposal, :assignment, :order, :report, :letter], # распоряжение, поручение, приказ, отчет, письмо
            :prefix => true
end

# == Schema Information
#
# Table name: documents
#
#  id                :integer          not null, primary key
#  title             :string
#  date_on           :date
#  tags              :text
#  document_type     :string
#  document_id       :integer
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  file_url          :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
