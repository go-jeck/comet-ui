Rails.application.routes.draw do
  get 'configuration/index'
  get 'dashboard/index'
  get 'login/index'
  
  get 'logout' => 'login#log_out'
  post '/login' => 'login#log_in'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
