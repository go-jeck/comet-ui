class LoginController < ApplicationController
  require 'httparty'
  require 'json'

  def index
    puts "Hiiiii"
  end

  def log_in
    puts "Hello"
    @response = HTTParty.get('http://localhost:8000/ping')
    json = JSON.parse(@response.body)
    if (json["success"] == "pong")
      redirect_to dashboard_index_path
    else
      redirect_to login_index_path
    end
  end
end
