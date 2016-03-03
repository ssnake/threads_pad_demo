class CsvImportJob < ThreadsPad::Job
	def work
		puts "start"
		self.max =1000
		1000.times.each do |i|
			debug "#{i}" if i % 100 == 0
			self.current+=1
			break if terminated?
			sleep 0.1
		end

	end
end