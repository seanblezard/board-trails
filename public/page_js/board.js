var boardController = function(){};
boardController.prototype = {
    loadCards: function(targetDiv, boardId) {			
			$.ajax({
		  	url: "/boards/" + boardId,
		  	type: "GET",
		  	context: document.body
			}).success(function(data) {
			  $(targetDiv).html(data);
			});
    }
};

$(document).ready(function() {       
	var controller = new boardController();
});

