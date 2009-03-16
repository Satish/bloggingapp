ActionController::Routing::Routes.draw do |map|
    
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

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
  
   map.root :controller => "posts"
   map.resources :posts
   map.resources :pages
   map.feed '/feed', :controller => "posts", :action => "feed"
   map.connect ':year/:month/:day/:permalink', :controller => 'posts', :action => 'show', :requirements => { :year => /\d+/ }
  
  
  map.namespace :admin do |admin|
    admin.root :controller => 'dashboard'
    admin.resources :posts
    admin.resources :comments
    admin.resources :pages
    admin.resources :tiny_mce_photos, :only => [:index, :create]
    admin.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete }
    
    admin.with_options :controller => 'users' do |user|
      user.signup '/signup', :action => 'new'
      user.register '/register', :action => 'create'
      user.activate '/activate/:activation_code', :action => 'activate', :activation_code => nil
    end
    
    admin.resources :sessions
    admin.with_options :controller => 'sessions' do |session|
      session.login  '/login', :action => 'new'
      session.logout '/logout', :action => 'destroy'
    end
  end
  
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
