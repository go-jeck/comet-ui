class DashboardController < ApplicationController
  require 'httparty'
  require 'json'

  def index
    response = HTTParty.get("http://localhost:8000/application")
    json_response = JSON.parse(response.body)
    @applications = Array.new
    for application in json_response do
      for namespace in application["namespace"] do
        app = App.new(application["application_name"], namespace, 0)
        @applications.push(app)
      end
    end
  end

    
end
