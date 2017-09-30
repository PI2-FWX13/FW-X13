Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "sessions#index"

  get 'windings/new' => 'windings#new' , as: 'new_winding'
  post 'windings/create' => 'windings#create' , as: 'create_windings'
  get 'windings/' => 'windings#index' , as: 'windings'
  get 'windings/:id' => 'windings#show' , as: 'show_winding'
#  get 'windings/edit/:id' => 'windings#edit', as: 'edit_winding'
#  patch 'windings/:id/edit', controller: 'windings', action: 'update', as: 'update_winding'
  get 'windings/destroy/:id', controller: 'windings', action: 'destroy', as: 'destroy_winding'

  get 'sessions/index' => 'sessions#index' , as: 'index_sessions'

  get '/configurations', :to => 'configurations#index', :as => 'configurations'
end
