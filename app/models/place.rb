class Place < ActiveRecord::Base
  attr_accessible :address, :description, :name, :photo_urls, :latitude, :longitude, :gmap, :visible

  geocoded_by :address
  after_validation :geocode, :process_photo_urls

  serialize :photo_urls

  acts_as_gmappable

  def gmaps4rails_address
    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    self.address 
  end

  def gmaps4rails_infowindow
    "<h4>#{ERB::Util.html_escape name}</h4><p>#{ERB::Util.html_escape description}</p>"
  end

  private

  def process_photo_urls
    self.photo_urls = self.photo_urls.split("\n") if self.photo_urls.is_a? String
  end
end
