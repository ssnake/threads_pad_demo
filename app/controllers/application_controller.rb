class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ThreadsPad::Helper
  protect_from_forgery with: :exception
  before_action :get_pad

  def start
  	@cancel = false
  	
  	if  !ThreadsPad::Pad.done?
            #cancel
  		ThreadsPad::Pad.terminate
  		@cancel = true
  	else	
	  	start_parsing params[:threads]  if params[:threads].present?
  	end
  end

  def get_pad
  	@pad = ThreadsPad::Pad.new session[:pad_id]	
  end

private
  def start_parsing threads
     # find out amount of lines in first tab of csv file
      fn = File.join Rails.root, 'public', 'demo.csv'
      csv = Roo::Spreadsheet.open(fn)
      sheet = csv.sheet(0)
      #div total amount of lines on number of threads
      chunk_length = sheet.count / threads.count
      mod = sheet.count % threads.count
      
      CsvImportJob.new(fn, 1 , chunk_length + mod).work
      return

      threads.count.times do |index|  
        if index == 0
         @pad << CsvImportJob.new(fn, index + 1 , chunk_length + mod) 
        else
          @pad << CsvImportJob.new(fn, index * chunk_length + mod + 1, chunk_length) 
        end
      end
      return 
      session[:pad_id] =  @pad.start
      @pad.log "Started at #{Time.now}"
  end
end
