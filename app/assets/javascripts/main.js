/*globals jQuery, Gmaps*/
jQuery(function ($) {
    "use strict";

    var jQueryCache, headerHeight, featuresHeight, ajdustSize, lastHeight;

    jQueryCache = {
        'window' : $(window),
        '.overallMap, .gmaps4rails_map' : $('.overallMap, .gmaps4rails_map'),
        'header' : $('header'),
        'featuresContainer' : $('.featuresContainer')
    };

    headerHeight = jQueryCache.header.outerHeight();
    featuresHeight = jQueryCache.featuresContainer.outerHeight();

    ajdustSize = function () {
        var height, windowHeight;

        windowHeight = jQueryCache.window.height();

        if (windowHeight === lastHeight) {
            //If the height does not change bail out
            return;
        }

        lastHeight = windowHeight;

        height = windowHeight - headerHeight - featuresHeight;

        jQueryCache['.overallMap, .gmaps4rails_map'].css('height', height + 'px');
    };

    ajdustSize();

    //On the first time re adjust it to compensate for the eventual size change
    if (Gmaps && Gmaps.map) {
        Gmaps.map.adjustMapToBounds();
    }

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
});