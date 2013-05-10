class Route < ActiveRecord::Base
  attr_accessible :name, :nid
  has_and_belongs_to_many :stops
end
