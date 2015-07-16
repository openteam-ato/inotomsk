class User < ActiveRecord::Base
  sso_auth_user
  attr_accessible :description, :email, :first_name, :last_name, :location, :name, :nickname, :phone
  has_many :permissions, :dependent => :destroy

  Permission.available_roles.each do |role|
    define_method "#{role}?" do
      permissions.map(&:role).include?(role)
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  uid                :string(255)
#  name               :text
#  email              :text
#  raw_info           :text
#  sign_in_count      :integer
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

