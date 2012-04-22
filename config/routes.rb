Improv::Application.routes.draw do

  get "invites/new"

  get "invites/create"

  get "invite/new"

  get "invite/create"

  #
  # ActiveAdmin routes.
  #
  # The ActiveAdmin routes cause Rails to set up a connection to the
  # production database, which isn't available during
  # assets:precompile on Heroku, so the following unless block skips
  # setting up these routes only when rake assets:precompile is
  # being run.
  #
  # Could be a problem if the assets needed these to be loaded to
  # compile properly; pretty sure they don't.
  #
  break if ARGV.join.include? 'assets:precompile'

  ActiveAdmin.routes(self)

# Seems to break things, don't use:
#  ActiveAdmin.routes(self) if (!$ARGV.nil? && $ARGV.find_all { |x| x =~ /migrate|rollback/i}.empty?)

  devise_for :admin_users, ActiveAdmin::Devise.config

  #
  # Generate some default routes for our models
  #

  resources :stories

  # There can only be one user logged in at once, and he has no need to see other users,
  # so use a singular "resource" and "user" rather than "resources" and "users"
  resource :user, :except => [:index, :show]

  resources :teams

  #
  # Omniauth routes
  #
  match "/auth/:provider/callback" => "sessions#create"
  match "/sign_out" => "sessions#destroy", :as => :sign_out
  match "/auth/failure" => "sessions#failure", :as => :authentication_failure

  #
  # Session route - callback for manual authentication
  #
  match "/sessions/create" => "sessions#create", :as => :manual_login

  #
  # Main root
  #
  root :to => "main#index"


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
  # match ':controller(/:action(/:id(.:format)))'
end
