(function( $ ) {

	//keep track of which results list item is selected
	//TODO change term to "results list"
	var resultsListIndex = 0;
	var resultsListActive = false;
	var opts;
	var lastEntered = "";
	var data;
	var resultsList;
	var resultsListID = "";
	var inputNode;

	$.fn.fs_suggest = function(options) {

		var defaults = {
			url	: 'https://api.foursquare.com/v2/venues/suggestcompletion?', // i suppose you could change this...
			ll : '37.787920,-122.407458', //default to SF since it's well known
			v : '20120609', //the date of the foursquare api version
			limit : 10, //perhaps an option to ignore limits
			intent: 'browse', //Looking for geo-specific results
			radius: 80000, //default to foursquare max of 80,000 meters (ll and radius are required with 'browse' intent)
			client_id : "YOUR_FS_CLIENT_ID", //get this from foursquare.com
			client_secret : "YOUR_FS_CLIENT_SECRET", //same
			style_results: true //set to false if the way i control the position of results, you can do it yourse
								//the default is to be right under the input and match the width of the input
								//and hopefully to adjust in a responsive way
		}
		//TODO would be cool to include a "schema : 'something.something.minivenues" in case your results had a different json structure

		opts = $.extend(defaults, options);
		inputNode = this;

		// Hide browser's default autocomplete
		inputNode.attr('autocomplete', 'off');

		this.keydown(function(event) {

			var code = event.keyCode || event.which;

			if (code == 13) {	//enter key is pressed
				onEnterKey(event);
			}
		});

		//TODO make this flexible enough to deal with other key events
		//wait for keyup to get total entered text
		this.keyup(function(event) {

			//("key up");
			var code = event.keyCode || event.which;

			//enter keys and and arrow keys should be caught by keydown
			if(code == 13) {
				//console.log("13 cancelling");
		    	return false;
		    }

			//only listen for up and down
			if(code == 38 || code == 40) {
				//onArrowKeyPressed(event.keyCode);
				return false
			}

			//console.log("keyup");
			//console.log($(this).val());
			justEntered = $(this).val();

			//since foursquare will only return minivenues on 3 characters
			//check if the value entered is 3 or more characters
			if(justEntered.length >= 3) {

				if(lastEntered != justEntered) {
					//send it off to foursquare
					console.log("call foursquare");
					callFoursquareSuggestion();
				}

				lastEntered = justEntered;
			}
			else {
				//clear what was entered before
				hideAndCleanup();
			}
		});



		//add global keyup on document
		this.keydown(function(event) {
			//console.log("window key up");
			var code = event.keyCode || event.which;

			if(code == 13) {
				//console.log("13 cancelling");
				onEnterKey(event);
		  }

			//only listen for up and down
			if(code == 38 || code == 40) {
				onArrowKeyPressed(event.keyCode);
			}
		});

		//listen for clicks or mouse moves away from the results list and hide it?

		//add the results ul (empty for now)
		//TODO probably should be able to customize id name or even class name
		//that way results could be populated to an already existing container
		addResultsList(this);
	};

	function onEnterKey(event) {
		//figure out if anything is selected
		if(resultsListActive) {
			//console.log("resulstListActive true: click " + "#" + resultsList.attr("id") + " .selected a");
			submitVenue();
		}
		event.preventDefault();
	}

	function addResultsList(el) {
		el.after("<ul id='fs_search_results'></ul>");
		//now add up and down listener to toggle and select results

		resultsList = $("#fs_search_results");
	}

	var fallback = false;
	function callFoursquareSuggestion() {
		//TODO check for options and set up some error checking
		url = opts.url
				+ "query=" + justEntered
				+ "&ll=" + opts.ll
				+ "&v=" + opts.v
				+ "&limit=" + opts.limit
				+ "&intent=" + opts.intent
				+ "&radius=" + opts.radius
				+ "&client_id=" + opts.client_id
				+ "&client_secret=" + opts.client_secret;
		safe_url = encodeURI(url);
		$.getJSON(safe_url, function() {
			//console.log("get search results ajax called");
		})
		.success(function(_data, status, xhr) {
			//console.log("success");
	        //console.log(_data);
			data = _data;
			if((data.response.minivenues && (data.response.minivenues.length > 0)) || fallback == true) {
				//if we have results OR this is the 2nd attempt, show results
				showResults();
			} else {
				//if nothing found in local radius, switch intent to global and re-call foursquare
				opts.intent = 'global';
				fallback = true;   //set global so we dont end up in infinite fail loop
				callFoursquareSuggestion();
			}
	    })
		.error(function() {
	        //TODO show some kind of error message
			//"this application doesn't MAKE errors"
	    });
	}

	// private methods?
	function showResults() {
		html = buildResultsList();
		//add or re-add
		//reset selection
		resultsListIndex = 0;
		resultsList.empty();
		resultsList.html(html);

		$("li.venue", resultsList).each(function() {
			$(this).on('click', function() {
				setSelected($(this).index());
				submitVenue();
			});
		});
	}

	function buildResultsList() {
		minivenues = data.response.minivenues;

		if(minivenues && minivenues.length > 0) {
			results = "";
			for (var i = 0; i < minivenues.length; i++) {
				v = minivenues[i]
				//TODO this should be customizable, at least for urls
				results += "<li class='venue'><a data-name='" + v.name + "' data-city='" + v.location.city +"' data-address='" + v.location.address +"' data-lat='" + v.location.lat +"' data-lng='" + v.location.lng +"' data-id='" + v.id +"'>" + v.name + "</a></li>";
			}
		} else {
			results = "<ul><li>Couldn't find that venue.</li></ul>";
		}

		return results;
	}

	function onArrowKeyPressed(code) {
		//TODO maybe add a check to be sure focus in on input, since it would be annoying
		//to activate this list if you were focused elsewhere

		//check for down or up key

		liLength = $("#" + resultsList.attr("id") + " li").size();

		//up
		if (code == 38) {
		   	upArrowPressed();
	       	return false;
	    }

		//down
		if (code == 40) {
		   	downArrowPressed();
			return false;
	    }
	}

	function downArrowPressed() {
		//console.log( "down pressed" );
		if(resultsListActive) {
			//console.log("active");
			//if active and last item in list
			if(resultsListIndex == liLength - 1) {
				//do nothing or return to top?
				//return to top
				//console.log("reached the end");
				setSelected(0);
			} else {
				//console.log("down arrow " + (resultsListSelectedIndex + 1));
				//console.log("results list selected index " + resultsListSelectedIndex);
				setSelected(resultsListSelectedIndex + 1);
			}

		} else {
			//console.log("not active, activate");
			//activate the list
			resultsListActive = true;
			setSelected(0);
		}
	}

	function upArrowPressed() {
		//console.log( "up pressed" );

		if(resultsListActive) {
			//get selected index
			if(resultsListSelectedIndex == 0) {
				//
				deactivateResultsList();
			} else {
				setSelected(resultsListSelectedIndex - 1);
			}

		} //else: they pressed up while cursor focus on input so ignore it
	}

	function deactivateResultsList() {
		resultsListSelectedIndex = 0;
		resultsListActive = false;
		$("#" + resultsList.attr("id") + " li").removeClass("selected");
	}

	function setSelected(index) {
		//console.log("set selected: " + index);
		resultsListSelectedIndex = index;
		$("#" + resultsList.attr("id") + " li").removeClass("selected");
		$("#" + resultsList.attr("id") + " li").eq(index).addClass("selected");
	}

	function submitVenue() {
		selectedVenue = $("#" + resultsList.attr("id") + " li.selected");

		// Trigger callback event
		inputNode.trigger('venue_selected.fq_suggest', {venueNode: selectedVenue});

		// Clear search query
		inputNode.val('');

		// Hide list and cleanup
		hideAndCleanup();
	}

	function hideAndCleanup() {
		deactivateResultsList();
		resultsList.empty();
		lastEntered = '';
	}


})( jQuery );
