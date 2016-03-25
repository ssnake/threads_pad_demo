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
  	
  end

  def status
  

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
      
      Unit.delete_all
      session[:started_at] = Time.now
      session[:threads_count] = threads.count

      #add events
      @pad.on :finish do |j|
        j.debug "Done at #{Time.now}"
        j.debug "Amount of units is #{Unit.count}"
        finish_date =  Time.now
        delta = (finish_date - Time.parse(session[:started_at])).round(2)
        j.debug "Time delta #{delta} s" if session[:started_at].present? 
        Stat.create! percents: @pad.current, threads_count: session[:threads_count], start: Time.parse(session[:started_at]), finish: finish_date, time_delta: delta
      end
      @pad.on(5..10) { |j| j.debug 'everything seems ok'}
      @pad.on(50..60) { |j| j.debug 'it reached half of work'}
      @pad.on(90..95) { |j| j.debug 'it\'s almost done'}

      
      session[:pad_id] =  @pad.start
      
      @pad.log "Started at #{Time.now}"
  end

end
