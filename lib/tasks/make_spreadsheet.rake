namespace :demo do
  desc "Make A Demo Spreadsheet File"
  task spreadsheet: :environment do
  	fn = File.join(Rails.root, 'public', 'demo.csv')
  	puts fn
  	File.open(fn,  "w+") do |f|
  		models = ['model A', 'model B', 'model C', 'model D', 'model E']
  		ship_ids = (1..100).to_a
  		cust_nos = *(1..20)
  		order_nos = *(1..100)
  		10000.times.each do |i|
  			#serial;model type;ship_id; ship_date; customer_no; ship_date; order_no;
  			f.write "S#{Random.rand(999999)};#{models[Random.rand(models.length)]};#{ship_ids[Random.rand(ship_ids.length)]};customer_#{cust_nos[Random.rand(cust_nos.length)]};#{DateTime.now-Random.rand(365*3)};order_#{order_nos[Random.rand(order_nos.length)]};\n"
  			puts i/10000.0*100.0
  		end
  	end

  end

end
