class Permission < ActiveRecord::Base
  sso_auth_permission :roles => [:admin, :map_manager]

  attr_accessible :role, :user_id
  belongs_to :user
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
