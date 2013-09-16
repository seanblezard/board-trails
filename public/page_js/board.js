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

    addLane: function(targetDiv, nameField, boardId, lane) {			
			$.ajax({
		  	url: "/boards/" + boardId + '/lanes',
		  	type: "POST",
		  	context: document.body,
		  	data: {name: lane}
			}).success(function(data) {
			  $(targetDiv).html(data);
			  $(nameField).val("");
			});
    }
};

$(document).ready(function() {       
	var controller = new boardController();	

	$("form").click(function(event){
		event.preventDefault();
	})

	$("#addLaneSubmit").click(function(){
		controller.addLane("#lanes", "#laneName", $("#laneCreationStatus").data("id"), $("#laneName").val());
	})

});

