Rails.application.routes.draw do
  get 'configuration' => 'configuration#index'
  get 'configuration/edit'
  get 'dashboard' => 'dashboard#index'
  get 'login' => 'login#index'
  
  get '/logout' => 'login#log_out'
  post '/login' => 'login#log_in'
  post '/commit' => 'configuration#commit_configurations'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
