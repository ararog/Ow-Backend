class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session,
      if: Proc.new { |c| c.request.format =~ %r{application/json} }
  
  def remote_ip
    if request.remote_ip != '127.0.0.1'
      request.remote_ip
    end
  end  
  
end
