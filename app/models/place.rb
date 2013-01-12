class Place < ActiveRecord::Base
  attr_accessible :address, :description, :name, :urls

  serialize :urls
end
