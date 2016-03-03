class CsvImportJob < ThreadsPad::Job
	def work
		puts "start"
		1000.times.each do |i|
			debug "#{i}" if i % 100 == 0
			break if terminated?
			sleep 0.1
		end

	end
end