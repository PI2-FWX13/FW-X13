Rails.application.routes.draw do

  root :to => "sessions#index"

  resources :machine_settings
  resources :windings
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
