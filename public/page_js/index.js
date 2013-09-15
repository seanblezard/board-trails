var boardsLoader = function(){};
boardsLoader.prototype = {
    perform: function() {
			/** Load the boards I can see **/
			$.ajax({
		  	url: "/boards",
		  	type: "GET",
		  	context: document.body
			}).success(function(data) {
			  $("#boards").html(data);
			});
    }
};

$(document).ready(function() {       
	var loader = new boardsLoader();
	loader.perform();
});