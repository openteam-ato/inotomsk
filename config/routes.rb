Inotomsk::Application.routes.draw do
  get '/(*path)', :to => 'main#index'
end
