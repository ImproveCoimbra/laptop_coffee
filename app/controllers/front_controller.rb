class FrontController < ApplicationController
  respond_to :html

  # GET /
  def index
    @places = Place.all
  end

end
