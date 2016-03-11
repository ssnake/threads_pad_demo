<% if @cancel %>
	console.log 'cancel is clicked'

<%else%>
	console.log 'start is clicked'
	$('#logs').empty()
	$('#percents').html('0')
	enable_buttons false
	start_import_timer()
<%end%>