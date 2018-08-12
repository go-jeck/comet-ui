class AppsController < ApplicationController
  require 'httparty'
  require 'json'
  before_action :login
  def index
    response = HTTParty.get("http://localhost:8000/application", :headers => {"Authorization" => cookies[:token]})
    @applications = JSON.parse(response.body)
  end

  def show
    response = HTTParty.get("http://localhost:8000/application/#{params[:app_name]}/namespaces", :headers => {"Authorization" => cookies[:token]})
    json_response = JSON.parse(response.body)
    @namespaces = json_response[0]["namespace"]
  end

  def new 
    headers = {"Authorization" => cookies[:token], "Content-Type"=> "application/json"}
    body = {:app_name => params[:app_name]}.to_json
    puts "app name = #{params[:app_name]}"
    url = "http://localhost:8000/application"
    response = HTTParty.post(url , :headers =>  headers, :body => body)
    puts "ntab #{response}"
    json = JSON.parse(response.body)
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
