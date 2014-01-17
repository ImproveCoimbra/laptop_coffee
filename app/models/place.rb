class Place < ActiveRecord::Base
  serialize :photo_urls
  after_validation :process_photo_urls

  validates :info_url, :format => { :with => /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/ix, :allow_blank => true }
  validates :name, :address, :presence => true

  # Ruby Geocoder
  #geocoded_by :address
  #after_validation :geocode, :if => lambda{ |obj| obj.address_changed? }
  reverse_geocoded_by :latitude, :longitude, :address => :location
  after_validation :reverse_geocode, :if => lambda{ |obj| obj.address_changed? }

  # Gmaps4Rails
  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_infowindow
    "<h3>#{ERB::Util.html_escape name}</h3>" #+ "<p>#{ERB::Util.html_escape description}</p>"
  end

  private

  def process_photo_urls
    self.photo_urls = self.photo_urls.split("\n") if self.photo_urls.is_a? String
  end
end
