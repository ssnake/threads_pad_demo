	$('#percents').html("<%= @pad.current%>")
<% if @pad.done? %>
<% @pad.log "Done at #{Time.now}"%>
<% @pad.log "Amount of units is #{Unit.count}"%>
<% @pad.log "Time delta #{Time.now - Time.parse(session[:started_at])}" if session[:started_at].present? %>
<% end %>
<% filter_job_logs(@pad.logs).each do |l|%>
	$('#logs').append("<%= format_log(l)%>")
<%end%>

<% #byebug %>
<% if @pad.done? %>
	stop_import_timer()
	enable_buttons()
<%end%>