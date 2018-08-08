class AppsController < ApplicationController
  require 'httparty'
  require 'json'
  before_action :login
  def index
    response = HTTParty.get("http://localhost:8000/application", :headers => {"Authorization" => cookies[:token]})
    
    json_response = JSON.parse(response.body)
    @applications = Array.new
    for application in json_response do
      app = App.new(application["application_name"], application["namespace"][0], 0)
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
end
