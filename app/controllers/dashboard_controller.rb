class DashboardController < ApplicationController
  def index
    @applications = Array.new
    for char in 'a'..'e' do
      app = App.new(char, "dev")
      @applications.push(app)
    end
  end
end
