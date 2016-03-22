	$('#percents').html("<%= @pad.current%>")

<% filter_job_logs(@pad.logs).each do |l|%>
	$('#logs').append("<%= format_log(l)%>")
<%end%>

<% #byebug %>
<% if @pad.done? %>
	stop_import_timer()
	enable_buttons()
<%end%>