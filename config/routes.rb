ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  map.resources :web_test, :collection => { :start => :post } do |web_test|
    web_test.resources :web_task, :collection => { :sort => :post }
    web_test.statistic 'statistic', :controller => :statistic, :action => :index
    web_test.statistic_cpu_data 'statistic_cpu_data', :controller => :statistic, :action => :cpu_data
    web_test.statistic_memory_data 'statistic_memory_data', :controller => :statistic, :action => :memory_data
    web_test.statistic_swap_data 'statistic_swap_data', :controller => :statistic, :action => :swap_data
    web_test.statistic_process_data 'statistic_process_data', :controller => :statistic, :action => :process_data
    web_test.statistic_web_data 'statistic_web_data', :controller => :statistic, :action => :web_data
  end
  map.compare_tasks_data 'compare_tasks_data/:web_task_id1/:web_task_id2', :controller => :statistic_comparison, :action => :data
  map.compare_tasks 'compare_tasks/:web_task_id1/:web_task_id2', :controller => :statistic_comparison, :action => :index
  map.compare_task 'compare_tasks/:web_task_id1', :controller => :statistic_comparison, :action => :index
  map.connect 'compare_tasks', :controller => :statistic_comparison, :action => :index
  map.root :controller => :web_test

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
