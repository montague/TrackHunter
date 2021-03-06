TrackHunter::Application.routes.draw do
  devise_for :users, :controllers => {:sessions => "devise/sessions"}, :path => 'accounts'

  resources :users do
    get :show
    resource :listener do
      get :home
      get :merchant_selection
    end
  end

  resources :merchants

  resources :songs

  resources :ratings

  devise_scope :user do
    get :show, :to => "devise/sessions#show"
    get :home, :to => "devise/sessions#home"
    # Used to help reroute from devise-generated login and sign up pages.
    get 'user', :to => "devise/sessions#home", :as => :user_root
    match 'user_root', :to => 'devise/sessions#home'
  end
  
  post "ratings/new"
  post "merchants/edit"
  root :to => "music_rating_services#index"
  
  get "music_rating_services/index"
  
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
