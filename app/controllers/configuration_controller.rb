class ConfigurationController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'httparty'
  require 'json'
  before_action :login

  def commit_configurations
    config_array = Array.new
    index_array = Array.new
    
    req_body = []

    params.each do |key, value|
      if !key["key-"].nil?
        index = key[4..-1]
        index_array.push(index)
      end
    end

    for index in index_array do
      config = Config.new(params["key-" + index], params["value-" + index])
      config_array.push(config)
    end

    config_array.each do |config|
      req_body.push({"key": config.key,"value": config.value})
    end
    response = HTTParty.post("http://localhost:8000/applications/#{params[:app_name]}/namespaces/#{params[:namespace_name]}/configurations",
      :body => req_body.to_json,
      :headers => { 'Content-Type' => 'application/json' , "Authorization" => cookies['token']})

    json_response = JSON.parse(response.body)
    if (json_response["status"] == 201)
      redirect_to configurations_path(params[:app_name],params[:namespace_name])
    else
      redirect_to apps_path, danger:"Add new configuration fail"
    end
  end
  
  def index
    url = "http://localhost:8000/applications/#{params[:app_name]}/namespaces/#{params[:namespace_name]}/configurations/latest"
    headers = {"Authorization" => cookies['token']}
    response = HTTParty.get(url, :headers => headers)
    response_body = JSON.parse(response.body)
    @configurations = response_body['configurations']
    @active_version = response_body['version']
  end

  def edit
    url = "http://localhost:8000/applications/#{params[:app_name]}/namespaces/#{params[:namespace_name]}/configurations/latest"
    headers = {"Authorization" => cookies['token']}
    response = HTTParty.get(url, :headers => headers)
    response_body = JSON.parse(response.body)
    @configurations = response_body['configurations']
    @active_version = response_body['version']
  end

  def rollback
    url = "http://localhost:8000/applications/#{params[:app_name]}/namespaces/#{params[:namespace_name]}/configurations/rollback"
    headers = {"Authorization" => cookies['token']}
    body = {
            "version" => params['version'].to_i
            }
    response = HTTParty.post(url, :headers => headers, :body => body.to_json)
    json_response = JSON.parse(response.body)
    if (json_response["status"] == 200)
      redirect_to configurations_path(params[:app_name],params[:namespace_name])
    else
      redirect_to apps_path, danger:"Rollback Failed"
    end
  end

end
