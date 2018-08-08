class LoginController < ApplicationController
  skip_before_action :verify_authenticity_token

  require 'httparty'
  require 'json'

  def index
    puts "Hiiiii"
  end

  def log_in
    @response = HTTParty.post('http://localhost:8000/login',
      :headers => {'Content-Type'=>'application/json'},
      :body => {:username => params['username'], :password => params['password']}.to_json)
      json = JSON.parse(@response.body)
      if (json["status"] == 200)
        cookies[:token] = { :value => json["token"], :expires => Time.now + 3600}
        redirect_to applications_path
      else
        #flash[:error] = 'Invalid Username or Password'
        redirect_to login_path, danger:"Invalid Username or Password"
      end

      puts json['token'].to_s
  end

  def log_out
    puts "Hello"
    @response = HTTParty.get('http://localhost:8000/ping')
    json = JSON.parse(@response.body)
    if (json["success"] == "pong")
      cookies.delete(:token)
      redirect_to login_path
    else
      redirect_to application_path
    end
  end
end
