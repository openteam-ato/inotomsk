Rails.application.routes.draw do
  # Redirect majestic seo bot to main page
  get '/ru/press-tsentr/novosti/v-rossii/prosmotr_novosti/-/:id', to: redirect('/404'), id: /.+http:\/ria\.ru\/nano_news\/20120222\/572000474\.html/

  devise_for :users, controllers: { invitations: 'manage/invitations' }

  devise_scope :user do
    get 'manage/invitations', to: 'manage/invitations#index'
  end

  namespace :manage do
    resource :user, only: [:edit, :update]
    resources :map_layers,  except: [:show]
    resources :placemarks,  except: [:index, :show]
    resources :permissions, except: [:show, :edit, :update]
    resources :events,      except: [:show]

    root to: 'map_layers#index'
  end

  namespace :workplace do
    resources :documents do
      get 'tags_list', on: :collection
      get 'participants_list', on: :collection
      get 'related_documents', on: :collection
    end

    resources :user_tags

    root to: 'documents#index'
  end

  get 'ru/inotomsk/ob-ekty'          => 'map_layers#index', :as => 'map_layers'
  get 'ru/dorozhnaya-karta'          => 'road_map#index',   :as => 'road_map'

  %w(
    peredovoe-proizvodstvo
    nauka-i-obrazovanie
    umnyy-i-udobnyy-gorod
    innovatsii-i-noviy-biznes
    delovaya-sreda
  ).each do |item|
    get "ru/#{item}" => 'directions#show', :defaults => { slug: item }, :as => item.underscore
  end

  %w(
    advanced-industry
    science-and-education
    technological-innovations-new-businesses
    smart-and-handy-city
    business-environment
  ).each do |item|
    get "en/#{item}" => 'directions#show', :defaults => { slug: item }, :as => item.underscore
  end

  # peredovoe proizvodsto
  %w(
    peredovoe-proizvodstvo/neftehimicheskiy-klaster
    peredovoe-proizvodstvo/klaster_yadernyh_tekhnologiy
    peredovoe-proizvodstvo/industrialnyy-park
    peredovoe-proizvodstvo/klaster-farmatsevtiki-medtehniki-i-it
    peredovoe-proizvodstvo/klaster-smart-technologiestomsk
    peredovoe-proizvodstvo/lesopromyshlennyy-klaster
    peredovoe-proizvodstvo/klaster-vozobnovlyaemyh-prirodnyh-resursov
    peredovoe-proizvodstvo/klaster-trudnoizvlekaemyh-prirod-resursov

    nauka-i-obrazovanie/nauchno-obrazovatelnyy-park
    nauka-i-obrazovanie/uchastie-v-federalnyh-initsiativah
    nauka-i-obrazovanie/tomskiy-natsionalnyy-issledovatelskiy-meditsinskiy-tsentr
    nauka-i-obrazovanie/detskiy-tehnopark-kvantorium
    nauka-i-obrazovanie/alyans-translyatsionnoy-meditsiny

    innovatsii-i-noviy-biznes/osobaya-ekonomicheskaya-zona
    innovatsii-i-noviy-biznes/poyas-innovatsionnyh-kompaniy

    umnyy-i-udobnyy-gorod/tomskaya-aglomeratsiya
    umnyy-i-udobnyy-gorod/tomskie-naberezhnye
    umnyy-i-udobnyy-gorod/meditsinskiy-park
    umnyy-i-udobnyy-gorod/istoriko-kulturnyy-park
    umnyy-i-udobnyy-gorod/sportivnyy-park
    umnyy-i-udobnyy-gorod/transportnaya-infrastruktura

  ).each do |item|
    get "ru/#{item}" => 'subdirections#show', :defaults => { slug: item.split('/').last }, :as => item.split('/').last.underscore
  end

  get 'en/road-map' => 'road_map#index'

  get 'files/:id/download' => 'workplace/documents#download', as: :download

  get '/(*path)', to: 'main#index'
  root to: 'main#index'
end
