Ylc::Application.routes.draw do
  # store routes
  root :to => 'application#root'

  resources :send_reminders, :only => :index

  devise_for :people, :controllers => { :sessions => 'people/sessions' } do
    get "/login" => "people/sessions#new"
    get "/logout" => "people/sessions#destroy"
  end

  resources :stores, :except => [:index, :new, :create] do
    resources :people do
      post 'search', :on => :collection
      get 'search', :on => :collection
      resources :customer_service_reminders
      resources :vehicles, :except => [:index, :show] do
        resources :customer_service_reminders
      end
      resources :pets, :except => [:index, :show] do
        resources :customer_service_reminders
      end
    end
  end

  # Company routes
  namespace :company do
    resources :companies, :only => [:show, :edit, :update]
  end

  # Admin routes
  namespace :admin do
    root :to => 'companies#index'
    resources :companies do
      resources :people
      resources :stores do
        get 'mass_assign_service_reminders', :on => :member
        # get 'assign_service_reminders', :on => :member
        match 'assign_service_reminders' => 'stores#assign_service_reminders', :as => 'assign_service_reminders'
        resources :service_reminders, :except => [:index]
      end
    end
    resources :service_reminders
  end


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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
