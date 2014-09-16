class PlacesController < ApplicationController
  respond_to :json

  # GET /places.json
  def index
    @json = Place.where(:visible => true).order(:name)
    respond_with @json, except: [:visible, :gmaps]
  end
end
