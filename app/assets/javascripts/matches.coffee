# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
	$.each gon.puzzle, (index) ->
		insertion = $("<h2></h2>").text("#{gon.puzzle[index]} ").attr({
			id : "container#{index}"
			style : "display: inline"
			})
		$('#puzzle-container').append(insertion)
