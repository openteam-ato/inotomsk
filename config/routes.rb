Inotomsk::Application.routes.draw do
  match "poll" => "poll#show", :via => :get
  get '/(*path)', :to => 'main#index'
  root :to => 'main#index'
end
