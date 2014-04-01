class FrontController < ApplicationController
  respond_to :html

  # GET /
  def index
    @json = Place.where(:visible => true).order(:name).to_gmaps4rails do |place, marker|
      #marker.json({ :id => place.name, :foo => place.address })
      marker.picture({
        :picture => ActionController::Base.helpers.asset_path('red-dot.png'),
        :width   => 32,
        :height  => 32,
        #:shadow_picture => "http://www.google.com/intl/en_us/mapfiles/ms/micons/msmarker.shadow.png",
        #:shadow_height => '32',
        #:shadow_width => '40',
        #:shadow_anchor => ['-26px', '-32px'],
      })
      sticker_icon = ActionController::Base.helpers.image_tag('icon-sticker.png', :class => 'place-icon', :title => t('.places.sticker_img_title', :year => place.sticker)) if place.sticker
      marker.sidebar "<li><div class='span3'><span class='place-name'>#{place.name}#{sticker_icon}</span></div></li></a>"
      marker.title place.name
    end
  end

end
