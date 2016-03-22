class MainController < ApplicationController
  include ThreadsPad::Helper
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
  
  def index
  	@stats = Stat.last(15)
  end

  def status
    if @pad.done?
    	@pad.log "Done at #{Time.now}"
      @pad.log "Amount of units is #{Unit.count}"
      finish_date =  Time.now
      delta = (finish_date - Time.parse(session[:started_at])).round(2)
      @pad.log "Time delta #{delta} s" if session[:started_at].present? 
      Stat.create! percents: @pad.current, threads_count: session[:threads_count], start: Time.parse(session[:started_at]), finish: finish_date, time_delta: delta
    end

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
      
      threads.count.times do |index|  
        if index == 0
         @pad << CsvImportJob.new(fn, index + 1 , chunk_length + mod) 
        else
          @pad << CsvImportJob.new(fn, index * chunk_length + mod + 1, chunk_length) 
        end
      end
      
      session[:pad_id] =  @pad.start
      Unit.delete_all
      session[:started_at] = Time.now
      session[:threads_count] = threads.count
      @pad.log "Started at #{Time.now}"
  end

end
