class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ThreadsPad::Helper
  protect_from_forgery with: :exception
  before_action :get_pad
  def start
  	@cancel = false
  	#cancel
  	if  !ThreadsPad::Pad.done?
  		ThreadsPad::Pad.terminate
  		@cancel = true
  	else	
	  	if params[:threads].present?
	  		params[:threads].count.times { @pad << CsvImportJob.new}
	  		session[:pad_id] =  @pad.start
	  		@pad.log "Started at #{Time.now}"
	  	
	  	end
  	end

  end
  def get_pad
  	@pad = ThreadsPad::Pad.new session[:pad_id]
  	
  end
  def status
  end
end
