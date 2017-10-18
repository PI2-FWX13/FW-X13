Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "sessions#index"

  get 'windings/new' => 'windings#new' , as: 'new_winding'
  post 'windings/' => 'windings#create' , as: 'create_windings'
  get 'windings/' => 'windings#index' , as: 'windings'
  get 'windings/show/:id' => 'windings#show' , as: 'show_winding'
  get 'windings/destroy/:id', controller: 'windings', action: 'destroy', as: 'destroy_winding'
  get 'windings/choose', controller: 'windings', action: 'choose' , as: 'choose_winding'
  get 'windings/monitor', controller: 'windings', action: 'monitor' , as: 'monitor_winding'
  get 'windings/gettemperature' => 'windings#gettemperature' , as: 'gettemperature_winding'

  get 'sessions/index' => 'sessions#index' , as: 'index_sessions'

  get '/configurations', :to => 'configurations#index', :as => 'configurations'
end
