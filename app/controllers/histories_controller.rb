class HistoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'httparty'
  require 'json'
  before_action :login

  def index
    headers = {"Authorization" => cookies['token']}
    url = "http://localhost:8000/applications/#{params[:app_name]}/namespaces/#{params[:namespace_name]}/histories"
    response = HTTParty.get(url, :headers => headers)
    @histories = JSON.parse(response.body)
  end

end
