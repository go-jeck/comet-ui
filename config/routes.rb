Rails.application.routes.draw do
  get 'dashboard/index'
  get 'login/index'
  # get 'log_in', to: 'login#log_in', as: 'log_in'
  get 'ping' => 'login#log_in'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
