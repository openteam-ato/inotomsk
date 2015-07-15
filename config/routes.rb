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
    resources :permissions, :only => [:index, :create, :new, :destroy]

    root :to => 'map_layers#index'
  end

  match "poll" => "poll#show", :via => :get
  get '/(*path)', :to => 'main#index'
  root :to => 'main#index'
end
