var boardController = function(){};
boardController.prototype = {
    loadBoards: function(targetDiv) {
			/** Load the boards I can see **/
			$.ajax({
		  	url: "/boards",
		  	type: "GET",
		  	context: document.body
			}).success(function(data) {
			  $(targetDiv).html(data);
			});
    },

    createBoard: function(targetDiv, name) {
			/** Create a new board **/
			$.ajax({
		  	url: "/boards",
		  	type: "POST",
		  	data: {name: name},
		  	context: document.body
			}).success(function(data) {
			  $(targetDiv).html(data);
			});
    }
};

$(document).ready(function() {       
	var controller = new boardController();
	controller.loadBoards("#boards");

	$("form").click(function(event){
		event.preventDefault();
	})

	$("#createBoardSubmit").click(function(){
		controller.createBoard("#boardCreationStatus", $("#boardName").val());
	})

});

