class Permission < ActiveRecord::Base
  attr_accessible :role, :user_id
  belongs_to :user

  extend Enumerize
  enumerize :role,
    in: [:admin, :map_manager, :inviter, :workplace_user],
    predicates: true

  def self.available_roles
    role.values
  end
end

# == Schema Information
#
# Table name: permissions
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  context_id   :integer
#  context_type :string(255)
#  role         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
