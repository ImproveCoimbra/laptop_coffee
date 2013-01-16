class FrontController < ApplicationController
  respond_to :html

  # GET /
  def index
    @json = Place.where(:visible => true).to_gmaps4rails do |place, marker|
      #marker.json({ :id => place.name, :foo => place.address })
      #marker.picture({
      #  :picture => "http://bundlr.com/images/favicon.png",
      #  :width   => 32,
      #  :height  => 32
      # })
      marker.sidebar "<span class=\"foo\">#{place.name}</span>"
      marker.title place.name
    end
  end

end
