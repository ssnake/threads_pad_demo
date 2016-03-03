	$('#percents').html("<%= @pad.current%>")
<% if @pad.done? %>
<% @pad.log "Done at #{Time.now}"%>
<% end %>
<% filter_job_logs(@pad.logs).each do |l|%>
	$('#logs').append("<%= format_log(l)%>")
<%end%>

<% #byebug %>
<% if @pad.done? %>
	stop_import_timer()
	enable_buttons()
<%end%>