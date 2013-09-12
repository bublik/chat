Chat::Application.routes.draw do
  resources :sites
  resources :site_categories

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

  devise_for :agents, :controllers => {:sessions => 'devise/sessions', :registrations => 'devise/registrations'}

  devise_scope :agent do
    get "/login", :to => "devise/sessions#new", :as => :login
    get "/signup", :to => "devise/registrations#new", :as => :signup
    get "/logout", :to => "devise/sessions#destroy", :as => :logout
  end

  root 'home#index'
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