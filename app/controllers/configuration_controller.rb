class ConfigurationController < ApplicationController
  require 'httparty'
  require 'json'
  before_action :init

  def init
    cfg_response = HTTParty.get("http://localhost:8000/configuration/#{params[:app]}/#{params[:namespace]}")
    json_cfg = JSON.parse(cfg_response.body)
    @app = App.new(params[:app], params[:namespace],json_cfg["version"])

    for app_cfg in json_cfg["configurations"] do
      config = Config.new(app_cfg["key"], app_cfg["value"])
      @app.configurations.push(config)
    end
  end
  
  def index
  end

  def edit
  end
end
