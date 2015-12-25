class User < ActiveRecord::Base

  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :invitable, :invite_for => 2.weeks

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :description, :email, :first_name, :last_name, :location, :name, :nickname, :phone, :current_password
  attr_accessor :current_password

  has_many :permissions, :dependent => :destroy

  Permission.available_roles.each do |role|
    define_method "#{role}?" do
      permissions.map(&:role).include?(role)
    end
  end

  def full_name
    name || [first_name, last_name, email].join(" ")
  end

end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  uid                    :string(255)
#  name                   :text
#  email                  :string(255)
#  nickname               :text
#  first_name             :text
#  last_name              :text
#  location               :text
#  description            :text
#  image                  :text
#  phone                  :text
#  urls                   :text
#  raw_info               :text
#  sign_in_count          :integer
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#
