ActionController::Routing::Routes.draw do |map|

   map.root :controller => "posts"
   map.resources :pages, :only => [:index]

   map.resources :posts, :only => [:show, :index]
   map.with_options :controller => 'pages' do |pages|
     pages.connect '/:permalink', :action => 'show'
   end

   map.with_options :controller => 'posts' do |posts|
     posts.feed '/feed', :action => "feed"
     posts.connect ':year/:month/:day/:permalink', :action => 'show', :requirements => { :year => /\d+/ }
   end

  map.namespace :admin do |admin|
    admin.root :controller => 'dashboard'
    admin.resource :blog, :controller => :blogs, :only => [:edit, :update]
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
    
    admin.resources :sessions, :only => [:create]
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
