/*globals jQuery*/
jQuery(function ($) {
    "use strict";

    var jQueryCache, headerHeight, featuresHeight, ajdustSize;

    jQueryCache = {
        'window' : $(window),
        '.overallMap, .gmaps4rails_map' : $('.overallMap, .gmaps4rails_map'),
        'header' : $('header'),
        'featuresContainer' : $('.featuresContainer')
    };

    headerHeight = jQueryCache.header.outerHeight();
    featuresHeight = jQueryCache.featuresContainer.outerHeight();

    ajdustSize = function () {
        var height;

        height = jQueryCache.window.height() - headerHeight - featuresHeight;

        jQueryCache['.overallMap, .gmaps4rails_map'].css('height', height + 'px');
    };

    ajdustSize();

    jQueryCache.window.bind('resize', ajdustSize);
});