#= require active_admin/base

#= require gmaps4rails/gmaps4rails.base
#= require gmaps4rails/gmaps4rails.googlemaps
#= require foursquare_suggest

$(document).ready ->

  return unless FS_CONFIG?

  $('input#place_foursquare_venue').fs_suggest
    'client_id':     FS_CONFIG['FOURSQUARE_CLIENT_ID']
    'client_secret': FS_CONFIG['FOURSQUARE_CLIENT_SECRET']
    'll': '40.2048286,-8.4403573'   # Coimbra
    'limit':  10
    'radius': 20000  # 20Km

  $('input#place_foursquare_venue').on 'venue_selected.fq_suggest', (event, data) ->
    venue = data.venueNode.find('a')

    $('input#place_name').val      venue.data 'name'
    $('input#place_address').val   if venue.data 'address' then "#{venue.data('address')}, #{venue.data('city')}" else ''
    $('input#place_info_url').val  if venue.data 'id'      then "http://foursquare.com/v/#{venue.data('id')}"     else ''
    $('input#place_latitude').val  venue.data('lat')
    $('input#place_longitude').val venue.data('lng')
