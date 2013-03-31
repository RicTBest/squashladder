# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery


$ ->
	$('.datetimepicker2').datetimepicker ->
	  language: 'en',
	  pick12HourFormat: true


$ ->
	$('.rankings_toggle').click ->
		$('.full').toggle()
		$('.partial').toggle()