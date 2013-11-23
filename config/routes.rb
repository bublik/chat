Chat::Application.routes.draw do

  match '/1px/(:user_usid)', to: 'locations#create', via: [:get]
  match '/site_config/(:lang)/(:id)', to: 'sites#show', via: [:get, :post]
  match '/visitor_feedbacks', to: 'site_feedbacks#list', via: [:get], as: :visitor_feedbacks

  root 'home#index'
  namespace :api do
    resource :messages, only: [:create]

    resource :users, only: [] do
      collection do
        post :online
        post :offline
        get 'state/:username', to: 'users#state'
      end
    end
  end

  resources :sites do
    resources :site_feedbacks, only: [:index, :create, :destroy]
  end

  resources :archive_collections, only: [:index, :show, :destroy] do
    collection do
      get :search
    end
    resources :archive_messages, only: [:index, :show, :destroy]
  end
  resources :site_categories
  resources :users

  get "management/index"
  get "management/report"
  get "home/index"
  get '/contact', to: "home#contact", as: :contact
  get '/help', to: "home#help", as: :help
  get '/price', to: "home#price", as: :price
  get '/about', to: "home#about", as: :about
  get '/releases', to: "home#releases", as: :releases
  get '/terms', to: "home#terms", as: :terms
  get '/privacy', to: "home#privacy", as: :privacy
  get '/career', to: "home#career", as: :career
  get '/stats', to: "home#stats", as: :stats
  match '/contact', to: 'home#contact', via: [:get, :post]

  devise_for :agents, :controllers => {:sessions => 'devise/sessions', :registrations => 'registrations'}
  resource :token_authentication, only: [:create, :destroy]
  devise_scope :agent do
    get "/login", :to => "devise/sessions#new", :as => :login
    get "/signup", :to => "devise/registrations#new", :as => :signup
    get "/logout", :to => "devise/sessions#destroy", :as => :logout
  end

  resources :plans
  resources :subscriptions do
    member do
      post :suspend
      post :reactivate
      post :cancel
    end
  end

  get 'paypal/checkout', to: 'subscriptions#paypal_checkout'

  get '/404', to: 'home#page404'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
