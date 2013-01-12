class Place < ActiveRecord::Base
  attr_accessible :address, :description, :name, :photo_urls

  geocoded_by :address
  after_validation :geocode

  serialize :photo_urls
end
