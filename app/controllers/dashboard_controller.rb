class DashboardController < ApplicationController
  require 'httparty'
  require 'json'
  before_action :login
  def index
    response = HTTParty.get("http://localhost:8000/application")
    json_response = JSON.parse(response.body)
    @applications = Array.new
    for application in json_response do
        app = App.new(application["application_name"], application["namespace"][0], 0)
        @applications.push(app)
    end
  end

    
end
