Rails.application.routes.draw do
  resources :interventions
  post 'twilio/sms'
  resources :quotes
  get 'quotes/quote'
  get 'errors/not_found'
  get 'errors/internal_server_error'
  get 'current_user' => "users#current_user"

  root "home#index"
 
  get 'dropbox/auth' => 'dropbox#auth'
  get 'dropbox/setup' => 'dropbox#setup'
  get 'dropbox/auth_callback' => 'dropbox#auth_callback'

  resources :leads, :path =>'leads'
  post '/leads', to: 'leads#create'


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # namespace :admin do
  #   controller :admin do
  #     get 'data/index', to: 'data#index'
  #     # get '/', action: :index
  #     # get :login
  #     # get :logout
  #   end
  #   # resources :events
  # end
  get 'rails_admin/data/index', to: 'data#index'
  get 'admin/rails_admin/data/index', to: 'data#index'
  get 'rails_admin/data/playbriefing', to: 'data#playbriefing'
  get 'rails_admin/data/map', to: 'data#map'


  # get '/', to: "home#index"
  get "residential", to: "home#residential"
  get "commercial", to: "home#commercial"
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  resources :quotes do 
    member do
      get 'preview'
    end
  end
  
  match "404", to: "errors#not_found", via: :all
  match "500", to: "errors#internal_server_error", via: :all

  get 'get_buildings_by_customer/:customerID', to: 'interventions#get_buildings_by_customer'  
  get '/building_search' => 'buildings#building_search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
