Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "sessions#main"

  get 'windings/new/:type' => 'windings#new' , as: 'new_winding'
  post 'windings/' => 'windings#create' , as: 'create_windings'
  get 'windings/' => 'windings#index' , as: 'windings'
  get 'windings/show/:id' => 'windings#show' , as: 'show_winding'
  get 'windings/destroy/:id', controller: 'windings', action: 'destroy', as: 'destroy_winding'
  get 'windings/choose', controller: 'windings', action: 'choose' , as: 'choose_winding'
  get 'windings/monitor/:id', controller: 'windings', action: 'monitor' , as: 'monitor_winding'
  get 'windings/graph', controller: 'windings', action: 'graph', as: 'monitor_graph'

  get 'windings/gettemperature' => 'windings#gettemperature' , as: 'gettemperature_winding'

  get 'sessions/index' => 'sessions#index' , as: 'index_sessions'
  get 'sessions/main' => 'sessions#main' , as: 'main_sessions'


  get 'mandril/edit/:id' => 'mandrils#edit', as: 'mandril_edit'
  patch 'mandril/update/:id'=> 'mandrils#update', as: 'mandril_update'

  get 'machine_settings/', :to => 'machine_settings#index', :as => 'machine_setting_index'
  get 'machine_settings/new' => 'machine_settings#new' , as: 'machine_setting_new'
  post 'machine_settings/' => 'machine_settings#create' , as: 'machine_setting_create'
  get 'machine_settings/show/:id' => 'machine_settings#show' , as: 'machine_setting'
  get 'machine_settings/edit/:id' => 'machine_settings#edit', as: 'machine_setting_edit'
  patch 'machine_settings/:id/edit', controller: 'machine_settings', action: 'update', as: 'machine_setting_update'
  get 'machine_settings/destroy/:id', controller: 'machine_settings', action: 'destroy', as: 'machine_setting_destroy'

  get 'conection_informations/new', to: 'conection_informations#new', as: 'conection_information_new'
  post 'conection_informations/', to: 'conection_informations#create', as:'conection_information_create'
  get 'conection_informations/', to: 'conection_informations#index', as: 'conection_information_index'
  get 'conection_information/edit/:id', to: 'conection_informations#edit', as: 'conection_information_edit'
  patch 'conection_information/update/:id', to: 'conection_informations#update', as: 'conection_information_update'
  get 'conection_informations/destroy/:id', to: 'conection_informations#destroy', as: 'conection_information_destroy'
end
