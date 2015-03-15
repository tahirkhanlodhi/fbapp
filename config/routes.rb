Rails.application.routes.draw do
  #devise_for :users
  get 'web_services/index'

  get 'home/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'
   resources :web_services do
     collection do
     get :sign_up_facebook
   end
   end


  devise_for :users, :controllers => {
      :sessions => "users/sessions",
      :confirmations => "users/confirmations",
      :passwords => "users/passwords",
      :unlocks => "users/unlocks",
      :omniauth => "users/omniauth_callbacks",
      :registrations => "users/registrations",

  }
  devise_scope :users do
    #get "admin", :to => "devise/sessions#new"
    #get "sign_in", :to => "users/sessions#new"
    get 'sign_in', :to => 'users/sessions#new', :as => :new_session
    get "sign_out", :to => "users/sessions#destroy"
    #post "sign_out", :to => "users/sessions#destroy"
    get "sign_up", :to => "users/registrations#new"
    patch "/users/update_user", :to => "users/registrations#update_user"
    #get "login", :to => "devise/sessions#login"
  end

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
