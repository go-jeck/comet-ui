class ConfigurationController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'httparty'
  require 'json'
  before_action :login
  before_action :load_app_configs, only: [:index, :edit]
  before_action :load_app_namespace, only: [:commit_configurations]
  def load_app_configs
    cfg_response = HTTParty.get("http://localhost:8000/configuration/#{params[:app]}/#{params[:namespace]}", :headers => {"Authorization" => cookies[:token]})
    json_cfg = JSON.parse(cfg_response.body)
    @app = App.new(params[:app], params[:namespace],json_cfg["version"])

    for app_cfg in json_cfg["configurations"] do
      config = Config.new(app_cfg["key"], app_cfg["value"])
      @app.configurations.push(config)
    end
  end

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
  end

  def edit
  end
end
