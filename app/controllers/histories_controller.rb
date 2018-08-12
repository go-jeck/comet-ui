class HistoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'httparty'
  require 'json'
  before_action :login

  def index
    headers = {"Authorization" => cookies['token']}
    url = "http://localhost:8000/configuration/history/#{params[:app_name]}/#{params[:namespace_name]}"
    response = HTTParty.get(url, :headers => headers)
    @histories = JSON.parse(response.body)
    render html: @histories
  end

end
