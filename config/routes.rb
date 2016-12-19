Rails.application.routes.draw do

  root 'pages#dashboard'

  match '/help', controller: 'pages', action: 'help', as: 'help', via: :get

  resources :box_movements

  resources :ivas, only: [:edit, :show, :update]

  #CUSTOMERS
  resources :customers
  match '/customers/:id/vehicles/:vehicle_id', controller: 'customers', action: 'delete_vehicle', as: 'delete_vehicle', via: :get
  match '/customers/:id/vehicles', controller: 'customers', action: 'vehicles', as: 'customer_vehicles', via: :get
  #CUSTOMERS
  resources :vehicles
  match 'vehicles/:id/owner', controller: 'vehicles', action: 'owner', as: 'owner_vehicle', via: :get

  resources :work_orders
  match '/work_orders/:id/budget', controller: 'work_orders', action: 'budget', as: 'budget', via: :get
  match '/work_orders/:id/deliver', controller: 'work_orders', action: 'deliver', as: 'work_order_deliver', via: :post

  devise_for :users, :skip => [:registration],  :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  resources :users
  resources :car_brands


  #ROUTES FOR HELP

  #routes for customer help
  match '/help/customers/new',   controller: 'help', action: 'new_customer',    as: 'help_new_customer',    via: :get
  match '/help/customers/edit',  controller: 'help', action: 'edit_customer',   as: 'help_edit_customer',   via: :get
  match '/help/customers/show',  controller: 'help', action: 'show_customer',   as: 'help_show_customer',   via: :get
  match '/help/customers/index', controller: 'help', action: 'index_customers', as: 'help_index_customers', via: :get
  #routes for box_movements help
  match '/help/box_movements/new',   controller: 'help', action: 'new_box_movement',    as: 'help_new_box_movement',    via: :get
  match '/help/box_movements/edit',  controller: 'help', action: 'edit_box_movement',   as: 'help_edit_box_movement',   via: :get
  match '/help/box_movements/show',  controller: 'help', action: 'show_box_movement',   as: 'help_show_box_movement',   via: :get
  match '/help/box_movements/index', controller: 'help', action: 'index_box_movements', as: 'help_index_box_movements', via: :get
  #routes for vehicels help
  match '/help/vehicles/new',   controller: 'help', action: 'new_vehicle',    as: 'help_new_vehicle',    via: :get
  match '/help/vehicles/edit',  controller: 'help', action: 'edit_vehicle',   as: 'help_edit_vehicle',   via: :get
  match '/help/vehicles/show',  controller: 'help', action: 'show_vehicle',   as: 'help_show_vehicle',   via: :get
  match '/help/vehicles/index', controller: 'help', action: 'index_vehicles', as: 'help_index_vehicles', via: :get
  #routes for work_order help
  match '/help/work_orders/new',          controller: 'help', action: 'new_work_order',           as: 'help_new_work_order',          via: :get
  match '/help/work_orders/edit',         controller: 'help', action: 'edit_work_order',          as: 'help_edit_work_order',         via: :get
  match '/help/work_orders/show',         controller: 'help', action: 'show_work_order',          as: 'help_show_work_order',         via: :get
  match '/help/work_orders/index',        controller: 'help', action: 'index_work_orders',        as: 'help_index_work_orders',       via: :get
  match '/help/work_orders/print',        controller: 'help', action: 'print_work_order',         as: 'help_print_work_order',        via: :get
  match '/help/work_orders/budget',       controller: 'help', action: 'budget_work_order',        as: 'help_budget_work_order',       via: :get
  match '/help/work_orders/budget/print', controller: 'help', action: 'print_budget_work_order',  as: 'help_print_budget_work_order', via: :get
  match '/help/work_orders/deliver',      controller: 'help', action: 'deliver_work_order',       as: 'help_deliver_work_order',      via: :get
  #routes for settings help
  match '/help/settings/iva/show',          controller: 'help', action: 'show_iva',         as: 'help_show_iva',          via: :get
  match '/help/settings/iva/edit',          controller: 'help', action: 'edit_iva',         as: 'help_edit_iva',          via: :get
  match '/help/settings/users/new',         controller: 'help', action: 'new_user',         as: 'help_new_user',          via: :get
  match '/help/settings/users/edit',        controller: 'help', action: 'edit_user',        as: 'help_edit_user',         via: :get
  match '/help/settings/users/show',        controller: 'help', action: 'show_user',        as: 'help_show_user',         via: :get
  match '/help/settings/users/index',       controller: 'help', action: 'index_users',      as: 'help_index_users',       via: :get
  match '/help/settings/car_brands/new',    controller: 'help', action: 'new_car_brand',    as: 'help_new_car_brand',     via: :get
  match '/help/settings/car_brands/edit',   controller: 'help', action: 'edit_car_brand',   as: 'help_edit_car_brand',    via: :get
  match '/help/settings/car_brands/show',   controller: 'help', action: 'show_car_brand',   as: 'help_show_car_brand',    via: :get
  match '/help/settings/car_brands/index',  controller: 'help', action: 'index_car_brands', as: 'help_index_car_brands',  via: :get




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
