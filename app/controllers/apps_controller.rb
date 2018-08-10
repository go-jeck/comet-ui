class AppsController < ApplicationController
  require 'httparty'
  require 'json'
  before_action :login
  def index
    response = HTTParty.get("http://localhost:8000/application", :headers => {"Authorization" => cookies[:token]})
    
    json_response = JSON.parse(response.body)
    @applications = Array.new
    for application in json_response do
      app = App.new(application["application_name"], nil, 0)
      @applications.push(app)
    end
  end
  def show
    response = HTTParty.get("http://localhost:8000/application", :headers => {"Authorization" => cookies[:token]})
    json_response = JSON.parse(response.body)
    
    @app = nil 
    for app in json_response do
      if app["application_name"] == params[:app]
        @app = {"application_name" => app["application_name"], "namespaces" => app["namespace"]}
        break
      end
    end
  end

  def new 
    headers = {"Authorization" => cookies[:token], "Content-Type"=> "application/json"}
    body = {:app_name => params['app_name']}.to_json
    puts "app name = #{params['app_name']}"
    url = "http://localhost:8000/application/create"
    response = HTTParty.post(url , :headers =>  headers, :body => body)
    puts "ntab #{response}"
    json = JSON.parse(response.body)
    redirect_to apps_path
  end
end
