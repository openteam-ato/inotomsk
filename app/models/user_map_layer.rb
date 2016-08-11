class UserMapLayer < ActiveRecord::Base
  belongs_to :user
end

# == Schema Information
#
# Table name: user_map_layers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  map_layer  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
