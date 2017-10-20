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

  get 'sessions/index' => 'sessions#index' , as: 'index_sessions'

  get 'machine_settings/', :to => 'machine_settings#index', :as => 'machine_settings'
  get 'machine_settings/new' => 'machine_settings#new' , as: 'new_machine_setting'
  post 'machine_settings/' => 'machine_settings#create' , as: 'create_machine_settings'
  get 'machine_settings/show/:id' => 'machine_settings#show' , as: 'show_machine_setting'
  get 'machine_settings/edit/:id' => 'machine_settings#edit', as: 'edit_machine_setting'
  patch 'machine_settings/:id/edit', controller: 'machine_settings', action: 'update', as: 'update_machine_setting'

  get 'machine_settings/destroy/:id', controller: 'machine_settings', action: 'destroy', as: 'destroy_machine_setting'
end
