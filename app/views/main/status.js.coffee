# $('#precents').html("<%=@pad.current%>%")
<% if @pad.done? %>
<% @pad.log "Done at #{Time.now}"%>
<% end %>
<% filter_job_logs(@pad.logs).each do |l|%>
	$('#logs').append("<%= "#{l[:id]}\t#{l[:msg]}"%><br>")
<%end%>
<% #byebug %>
<% if @pad.done? %>
	stop_import_timer()
	enable_buttons()
<%end%>