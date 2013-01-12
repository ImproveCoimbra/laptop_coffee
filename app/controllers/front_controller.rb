class FrontController < ApplicationController
  respond_to :html

  # GET /
  def index
    @places = Place.all
    @json = Place.all.to_gmaps4rails
  end

end
