class Address < ActiveRecord::Base
  attr_accessible :latitude, :longitude

  belongs_to :placemark
end

# == Schema Information
#
# Table name: addresses
#
#  id           :integer          not null, primary key
#  latitude     :float
#  longitude    :float
#  placemark_id :integer
#
