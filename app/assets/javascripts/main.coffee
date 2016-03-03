# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@get_stauts = () ->
	$.ajax({
		url:"/main/status",
		dataType: 'script'
		settings: 
			beforeSend: (xhr)->
	    		xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
		})
@start_import_timer = () ->
	@import_timer = setInterval(
		() -> 
			if window.location.pathname == '/'
				get_stauts()		 
	
			else
				stop_import_timer()
	, 3000)
	console.log 'start_import_timer'

@stop_import_timer = () -> 
	clearInterval(@import_timer)
	console.log 'stop_import_timer'

$(document).on 'click', '.start', (e) ->
	#console.log 'start clicked'
	btn = $(e.target)
	true

@enable_buttons = (enable=true) ->
	if enable
		$('.start').html('Start')
		$('.start').removeClass('dis')
	else
		$('.start').html('Cancel')
		$('.start').addClass('dis')
