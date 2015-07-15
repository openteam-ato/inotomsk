Inotomsk::Application.routes.draw do
  namespace :manage do
    resources :map_layers, :except => [:show]
    resources :placemarks, :except => [:index, :show]
  end

  match "poll" => "poll#show", :via => :get
  get '/(*path)', :to => 'main#index'
  root :to => 'main#index'
end
