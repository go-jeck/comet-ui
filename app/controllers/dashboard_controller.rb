class DashboardController < ApplicationController
  require 'httparty'
  require 'json'

  def index
    response = HTTParty.get("http://localhost:8000/application")
    json_response = JSON.parse(response.body)
    @applications = Array.new
    for app in json_response do
      app = App.new(app["application_name"], app["namespace"])
      @applications.push(app)
    end
  end
end
