class Place < ActiveRecord::Base
  attr_accessor :foursquare_venue # Used for the ActiveAdmin form only

  serialize :photo_urls
  after_validation :process_photo_urls

  validates :info_url, :format => { :with => /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/ix, :allow_blank => true }
  validates :name, :latitude, :longitude, :presence => true

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
