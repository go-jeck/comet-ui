Rails.application.routes.draw do
  get 'configuration/edit'
  get 'apps' => 'apps#index'
  get '/apps/:app', to: 'apps#show', as: 'app'
  get '/apps/:app/:namespace' => 'configuration#index'
  post '/apps/new' => 'apps#new'
  get 'login' => 'login#index'
  get '/logout' => 'login#log_out'
  post '/login' => 'login#log_in'
  post '/commit' => 'configuration#commit_configurations'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
