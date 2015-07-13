Inotomsk::Application.routes.draw do
  namespace :manage do
    resources :map_layers
    resource :placemarks, :except => [:show]
  end

  match "poll" => "poll#show", :via => :get
  get '/(*path)', :to => 'main#index'
  root :to => 'main#index'
end
