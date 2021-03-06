Rails.application.routes.draw do
  root 'apps#index'
  
  get '/login', to: 'login#index', as: 'login'
  get '/logout', to: 'login#log_out', as: 'logout'
  
  get '/apps', to: 'apps#index', as: 'apps'
  get '/apps/:app_name', to: 'apps#show', as: 'app'
  
  get '/apps/:app_name/:namespace_name', to: 'configuration#index', as: 'configurations'
  get '/apps/:app_name/:namespace_name/configurations/edit', to: 'configuration#edit', as: 'edit_configuration'

  get '/apps/:app_name/:namespace_name/histories', to: 'histories#index', as: 'histories'

  post '/login' => 'login#log_in'
  
  post '/apps/new' => 'apps#new'
  post '/apps/:app_name/new' => 'apps#add_namespace'
  
  post '/apps/:app_name/:namespace_name/configurations/' => 'configuration#commit_configurations'

  post '/apps/:app_name/:namespace_name/rollback' => 'configuration#rollback'
end
