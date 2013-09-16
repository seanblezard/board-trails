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
    },
    addLane: function(targetDiv, boardId, lane) {			
    	alert(boardId);
			$.ajax({
		  	url: "/boards/" + boardId + '/lanes',
		  	type: "POST",
		  	context: document.body,
		  	data: {name: lane}
			}).success(function(data) {
			  $(targetDiv).html(data);
			});
    }
};

$(document).ready(function() {       
	var controller = new boardController();	

	$("form").click(function(event){
		event.preventDefault();
	})

	$("#addLaneSubmit").click(function(){
		controller.addLane("#laneCreationStatus", $("#laneCreationStatus").data("id"), $("#laneName").val());
	})

});

