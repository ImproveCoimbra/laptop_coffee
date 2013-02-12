/*globals jQuery, Gmaps*/
jQuery(function ($) {
    "use strict";

    var jQueryCache, headerHeight, featuresHeight, ajdustSize, lastHeight;

    jQueryCache = {
        'window' : $(window),
        '.overallMap, .gmaps4rails_map, .list-wrapper' : $('.overallMap, .gmaps4rails_map, .list-wrapper'),
        'header' : $('header'),
        'featuresContainer' : $('#features-section h4')
    };

    headerHeight = jQueryCache.header.outerHeight();
    featuresHeight = jQueryCache.featuresContainer.outerHeight(true);

    ajdustSize = function () {
        var height, windowHeight;

        windowHeight = jQueryCache.window.height();
        
        if (windowHeight === lastHeight) {
            //If the height does not change bail out
            return;
        }

        lastHeight = windowHeight;

        height = windowHeight - headerHeight - featuresHeight;

        jQueryCache['.overallMap, .gmaps4rails_map, .list-wrapper'].css('height', height + 'px');
    };

    ajdustSize();

    //Probably we should throtle this
    jQueryCache.window.bind('resize', ajdustSize);


    //Geolocation success callback
    Gmaps.map.geolocationSuccess = function () {
        Gmaps.map.createMarker({
           Lat: Gmaps.map.userLocation.lat(),
           Lng: Gmaps.map.userLocation.lng(), 
           rich_marker: null, 
           marker_picture: "/assets/my_position_marker.png",
           marker_width: 16,
           marker_height: 16,
           marker_anchor: null,
           shadow_anchor: null,
           shadow_picture: null,
           shadow_width: null,
           shadow_height: null,
        });
    };

  // Map Load callback
  Gmaps.map.callback = function() {

    // Close open infoboxes on map click
    google.maps.event.addListener(Gmaps.map.serviceObject, "click", function() {
      if (Gmaps.map.visibleInfoWindow != null) { Gmaps.map.visibleInfoWindow.close(); }
    });

    // On the first time re-adjust it to compensate for the eventual size change
    Gmaps.map.adjustMapToBounds();

    for (var i = 0; i <  this.markers.length; ++i) {
      google.maps.event.addListener(Gmaps.map.markers[i].serviceObject, 'mouseover', function() {
        this.setIcon('http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png');
        //if (this.getAnimation() == null)
        //  this.setAnimation(google.maps.Animation.BOUNCE);
      });

      google.maps.event.addListener(Gmaps.map.markers[i].serviceObject, 'mouseout', function() {
        this.setIcon('http://www.google.com/intl/en_us/mapfiles/ms/micons/red-dot.png');
        //this.setAnimation(null);
      });

      //google.maps.event.addListener(Gmaps.map.markers[i].serviceObject, 'click', function() {
      //  var i = this.__gm_id - 1;
      //  $($("#markers-list li")[i]).addClass("active");
      //});
    }
  };

  $("#markers-list li").live("mouseover", function(){
    var i = $(this).index();
    var marker = Gmaps.map.markers[i].serviceObject;
    //if (marker.getAnimation() == null)
      //marker.setAnimation(google.maps.Animation.BOUNCE);
    marker.setIcon('http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png');
  });

  $("#markers-list li").live("mouseout", function(){
    var i = $(this).index();
    var marker = Gmaps.map.markers[i].serviceObject;
    //marker.setAnimation(null);
    marker.setIcon('http://www.google.com/intl/en_us/mapfiles/ms/micons/red-dot.png');
  });
});
