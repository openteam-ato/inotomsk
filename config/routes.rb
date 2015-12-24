Rails.application.routes.draw do

  devise_for :users, :controllers => { :invitations => "manage/invitations" }

  devise_scope :user do
    get "manage/invitations", to: "manage/invitations#index"
  end

  namespace :manage do
    resource :user, :only => [:edit, :update]
    resources :map_layers,  :except => [:show]
    resources :placemarks,  :except => [:index, :show]
    resources :permissions, :except => [:show, :edit, :update]
    resources :events,      :except => [:show]

    root :to => 'map_layers#index'
  end

  namespace :workplace do
    root :to => 'welcome#index'
  end

  get "ru/inotomsk/ob-ekty"          => "map_layers#index", :as => 'map_layers'
  get "ru/dorozhnaya-karta"          => "road_map#index",   :as => 'road_map'

  %w[
    peredovoe-proizvodstvo
    nauka-i-obrazovanie
    umnyy-i-udobnyy-gorod
    innovatsii-i-noviy-biznes
    delovaya-sreda
  ].each do |item|
    get "ru/#{item}" => 'directions#show', :defaults => { :slug => item }, :as => item.underscore
  end

  %w[
    advanced-industry
    science-and-education
    technological-innovations-new-businesses
    smart-and-handy-city
    business-environment
  ].each do |item|
    get "en/#{item}" => 'directions#show', :defaults => { :slug => item }, :as => item.underscore
  end

  # peredovoe proizvodsto
  %w[
    peredovoe-proizvodstvo/neftehimicheskiy-klaster
    peredovoe-proizvodstvo/klaster_yadernyh_tekhnologiy
    peredovoe-proizvodstvo/industrialnyy-park
    peredovoe-proizvodstvo/klaster-farmatsevtiki-medtehniki-i-it
    peredovoe-proizvodstvo/lesopromyshlennyy-klaster
    peredovoe-proizvodstvo/klaster-vozobnovlyaemyh-prirodnyh-resursov
    peredovoe-proizvodstvo/klaster-trudnoizvlekaemyh-prirod-resursov

    nauka-i-obrazovanie/nauchno-obrazovatelnyy-park
    nauka-i-obrazovanie/uchastie-v-federalnyh-initsiativah

    umnyy-i-udobnyy-gorod/tomskaya-aglomeratsiya
    umnyy-i-udobnyy-gorod/tomskie-naberezhnye
    umnyy-i-udobnyy-gorod/meditsinskiy-park
    umnyy-i-udobnyy-gorod/istoriko-kulturnyy-park
    umnyy-i-udobnyy-gorod/sportivnyy-park
    umnyy-i-udobnyy-gorod/transportnaya-infrastruktura

   ].each do |item|
     get "ru/#{item}" => 'subdirections#show', :defaults => { :slug => item.split('/').last }, :as => item.split('/').last.underscore
  end

  get "en/road-map" => "road_map#index"

  match "poll" => "poll#show", :via => :get
  get '/(*path)', :to => 'main#index'
  root :to => 'main#index'
end
