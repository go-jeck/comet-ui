class AppsController < ApplicationController
  require 'httparty'
  require 'json'
  before_action :login
  def index
    response = HTTParty.get("http://localhost:8000/application", :headers => {"Authorization" => cookies[:token]})
    json_response = JSON.parse(response.body)
    
    unless json_response.nil?
      @applications = Array.new
      for application in json_response do
        app = App.new(application["application_name"], nil, 0)
        @applications.push(app)
      end
    end
  end
  def show
    response = HTTParty.get("http://localhost:8000/application", :headers => {"Authorization" => cookies[:token]})
    json_response = JSON.parse(response.body)
    
    @app = nil 
    for app in json_response do
      if app["application_name"] == params[:app_name]
        @app = {"application_name" => app["application_name"], "namespaces" => app["namespace"]}
        puts "WKWKKW#{@app}"
        break
      end
    end
  end

  def new 
    headers = {"Authorization" => cookies[:token], "Content-Type"=> "application/json"}
    body = {:app_name => params[:app_name]}.to_json
    puts "app name = #{params[:app_name]}"
    url = "http://localhost:8000/application"
    response = HTTParty.post(url , :headers =>  headers, :body => body)
    puts "ntab #{response}"
    json = JSON.parse(response.body)
    render html: json;
    redirect_to apps_path
  end

  def add_namespace
    headers = {"Authorization" => cookies[:token], "Content-Type"=> "application/json"}
    body = {:namespace_name => params[:namespace_name]}.to_json
    puts "namespace name = #{params[:namespace_name]}"
    url = "http://localhost:8000/application/#{params[:app_name]}"
    
    response = HTTParty.post(url , :headers =>  headers, :body => body)
    puts "ntab #{params[:app_name]}"
    json = JSON.parse(response.body)
    redirect_to app_path(params[:app_name])
  end
  
end
