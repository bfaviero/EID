class Building < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :mit, :name
  geocoded_by :address
  after_validation :geocode
end
