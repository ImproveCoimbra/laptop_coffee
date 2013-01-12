class Place < ActiveRecord::Base
  attr_accessible :address, :description, :name, :photo_urls

  serialize :photo_urls
end
