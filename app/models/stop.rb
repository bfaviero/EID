class Stop < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode
  has_and_belongs_to_many :routes
  attr_accessible :latitude, :longitude, :name, :nid
end
