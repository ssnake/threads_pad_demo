module MainHelper
	def format_log log
		"#{log[:msg]}\<br\>".html_safe
	end
end
