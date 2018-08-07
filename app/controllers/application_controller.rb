class ApplicationController < ActionController::Base

  add_flash_types :danger, :info, :warning, :success 
  private
  def login
    unless cookies[:token]
      redirect_to login_path
    end
  end
  helper_method :login
end
