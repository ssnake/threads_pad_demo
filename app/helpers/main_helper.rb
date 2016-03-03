module MainHelper
	def format_log log
		"#{log[:id]}\t#{log[:msg]}\<br\>".html_safe
	end
end
