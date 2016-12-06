Rails.application.routes.draw do

  root 'pages#dashboard'

  match 'box_movements/extra_data', controller: 'box_movements', action: 'extra_data', as: 'extra_data', via: :get
  resources :box_movements
  #CUSTOMERS
  resources :customers
  match '/customers/:id/vehicles/:vehicle_id', controller: 'customers', action: 'delete_vehicle', as: 'delete_vehicle', via: :get
  match '/customers/:id/vehicles', controller: 'customers', action: 'vehicles', as: 'customer_vehicles', via: :get
  #CUSTOMERS
  resources :vehicles
  match 'vehicles/:id/owner', controller: 'vehicles', action: 'owner', as: 'owner_vehicle', via: :get

  resources :work_orders
  match '/work_orders/:id/budget', controller: 'work_orders', action: 'budget', as: 'budget', via: :get
  match '/work_orders/:id/finalize', controller: 'work_orders', action: 'finalize', as: 'work_order_finalize', via: :get

  devise_for :users, :skip => [:registration],  :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  resources :users
  resources :car_brands


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
