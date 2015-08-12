Inotomsk::Application.routes.draw do
  devise_for :users, :path => 'auth',
    :controllers => { :omniauth_callbacks => 'sso_auth/omniauth_callbacks'},
    :skip => [:sessions]

  devise_scope :users do
    get 'sign_out' => 'sso-auth/sessions#destroy', :as => :destroy_user_session
    get 'sign_in' => redirect('/auth/auth/identity'), :as => :new_user_session
  end

  namespace :manage do
    resources :map_layers,  :except => [:show]
    resources :placemarks,  :except => [:index, :show]
    resources :permissions, :except => [:show, :edit, :update]
    resources :events,      :except => [:show]

    root :to => 'map_layers#index'
  end

  get "ru/inotomsk/ob-ekty"          => "map_layers#index", :as => 'map_layers'
  get "ru/dorozhnaya-karta"          => "road_map#index",   :as => 'road_map'

  %w[peredovoe-proizvodstvo nauka-i-obrazovanie umnyy-i-udobnyy-gorod innovatsii-i-noviy-biznes delovaya-sreda].each do |item|
    get "ru/#{item}" => 'directions#show', :defaults => { :slug => item }
  end

  get "en/road-map" => "road_map#index"

  match "poll" => "poll#show", :via => :get
  get '/(*path)', :to => 'main#index'
  root :to => 'main#index'
end
