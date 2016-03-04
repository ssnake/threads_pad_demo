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
			row = sheet.row(current_row)
			parse row.first.split ';'
			break if terminated?
			current_row += 1
			self.current +=1
		end
		

	end
	def parse arg
		 Unit.create serial: arg[0], model_type: arg[1], ship_id: arg[2], customer_no: arg[3], ship_date: arg[4], order_no: arg[5]
	end
end