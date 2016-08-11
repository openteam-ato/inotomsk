class UserTag < ActiveRecord::Base
  belongs_to :user

  validates :tag, presence: true, uniqueness: { scope: :user_id }
end

# == Schema Information
#
# Table name: user_tags
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  tag        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
