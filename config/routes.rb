Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "sessions#index"

  get 'windings/new/:type' => 'windings#new' , as: 'new_winding'
  post 'windings/' => 'windings#create' , as: 'create_windings'
  get 'windings/' => 'windings#index' , as: 'windings'
  get 'windings/show/:id' => 'windings#show' , as: 'show_winding'
  get 'windings/destroy/:id', controller: 'windings', action: 'destroy', as: 'destroy_winding'
  get 'windings/choose', controller: 'windings', action: 'choose' , as: 'choose_winding'
  get 'windings/monitor', controller: 'windings', action: 'monitor' , as: 'monitor_winding'
  get 'windings/graph', controller: 'windings', action: 'graph', as: 'monitor_graph'
  get 'sessions/index' => 'sessions#index' , as: 'index_sessions'

  get 'mandril/edit/:id' => 'mandrils#edit', as: 'mandril_edit'
  patch 'mandril/update/:id'=> 'mandrils#update', as: 'mandril_update'

  get '/configurations', :to => 'configurations#index', :as => 'configurations'
  get 'machine_settings/', :to => 'machine_settings#index', :as => 'machine_setting_index'
  get 'machine_settings/new' => 'machine_settings#new' , as: 'machine_setting_new'
  post 'machine_settings/' => 'machine_settings#create' , as: 'machine_setting_create'
  get 'machine_settings/show/:id' => 'machine_settings#show' , as: 'machine_setting'
  get 'machine_settings/edit/:id' => 'machine_settings#edit', as: 'machine_setting_edit'
  patch 'machine_settings/:id/edit', controller: 'machine_settings', action: 'update', as: 'machine_setting_update'
  get 'machine_settings/destroy/:id', controller: 'machine_settings', action: 'destroy', as: 'machine_setting_destroy'
end
