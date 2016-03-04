class CsvImportJob < ThreadsPad::Job
	def initialize filename, start_row, count
		puts "filename: #{filename}, start row: #{start_row}, count: #{count}"
		@filename = filename
		@start_row = start_row
		@count = count
	end
	def work
		sheet = Roo::Spreadsheet.open(@filename).sheet(0)
		current_row = @start_row
		self.max = @count
		while current_row < @start_row + @count do
			h = sheet.row(current_row)
			parse h
			break if terminated?
			current_row += 1
			self.current +=1
		end
		

	end
	def parse hash
		 puts hash.inspect
	end
end