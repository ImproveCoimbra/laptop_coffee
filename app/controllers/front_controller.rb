class FrontController < ApplicationController
  respond_to :html

  # GET /
  def index
    @places = Place.all
    @json = Place.all.to_gmaps4rails do |place, marker|
      marker.json({ :id => place.name, :foo => place.address })
      #marker.picture({
      #  :picture => "http://bundlr.com/images/favicon.png",
      #  :width   => 32,
      #  :height  => 32
      # })
      marker.title place.name
    end
  end

end
