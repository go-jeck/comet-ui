class ConfigurationController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'httparty'
  require 'json'
  before_action :login
  # before_action :load_app_namespace, only: [:commit_configurations]

  def load_app_namespace
    cfg_response = HTTParty.get("http://localhost:8000/configuration/#{params[:app]}/#{params[:namespace]}")
    json_cfg = JSON.parse(cfg_response.body)
    @app = App.new(params[:app], params[:namespace],json_cfg["version"])
  end

  def commit_configurations
    config_array = Array.new
    index_array = Array.new
    
    req_body = {
      "appName" => "#{params[:app]}",
      "namespace" => "#{params[:namespace]}",
      "data" => []
    }

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
      req_body["data"].push({"key": config.key,"value": config.value})
    end

    response = HTTParty.post("http://localhost:8000/configuration",
      :body => req_body.to_json,
      :headers => { 'Content-Type' => 'application/json' })

    json_response = JSON.parse(response.body)

    if (json_response["status"] == 201)
      redirect_to configuration_path(params: {namespace: @app.namespace, app: @app.name}, method: :get)
    else
      redirect_to apps_path
    end
  end
  
  def index
    url = "http://localhost:8000/application/#{params['app']}/namespaces/#{params['namespace']}/configurations"
    headers = {"Authorization" => cookies['token']}
    response = HTTParty.get(url, :headers => headers)
    @configurations = JSON.parse(response.body)
  end

  def edit

  end
end
