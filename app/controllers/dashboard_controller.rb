class DashboardController < ApplicationController
  def index
    @applications = Array.new
    for char in 'a'..'e' do
      @applications.push(char)
    end
  end
end
