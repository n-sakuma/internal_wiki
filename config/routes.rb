InternalWiki::Application.routes.draw do

  root :to => "wiki_informations#index"

  match "search/(*search_request)", :to => "search#index", :as => 'search'

  get "login" => "sessions#new", :as => "login"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy", :as => "logout"
  get "logout" => "sessions#destroy" # ログインできなくなる対策で
  match "oauth/callback" => "sessions#callback"
  match "oauth/:provider" => "sessions#oauth", :as => :auth_at_provider

  match "/setting" => "users#setting", :as => 'user_setting', :via => :get
  match "/setting/:id" => "users#update", :as => 'update_setting', :via => :put

  namespace :admin do
    resources :users do
      member do
        post :add_visibility_wiki
        delete :delete_visibility_wiki
      end
    end
  end

  get '/' => 'wiki_informations#index', :as => 'wiki_infos'
  get 'wiki_info/new' => 'wiki_informations#new', :as => 'new_wiki_info'
  post 'wiki_infos' => 'wiki_informations#create', :as => 'wiki_infos'
  get ':wiki_name' => 'wiki_informations#show', :as => 'wiki_info'
  get ':wiki_name/edit' => 'wiki_informations#edit', :as => 'edit_wiki_info'
  put ':wiki_name' => 'wiki_informations#update', :as => 'wiki_info'
  delete ':wiki_name' => 'wiki_informations#destroy', :as => 'wiki_info'

  scope ':wiki_name/' do
    get ':page_name' => 'pages#show', :as => 'page'
    get ':page_name/edit' => 'pages#edit', :as => 'edit_page'
    delete ':page_name' => 'pages#destroy', :as => 'page'
    get ':page_name/histories' => 'pages#histories', :as => 'histories_page'
    put ':page_name' => 'pages#revert', :as => 'revert_page'
    post 'add_authority_user' => 'wiki_informations#add_authority_user', :as => 'add_authority_user'
    delete '/remove_authority_user' => 'wiki_informations#remove_authority_user', :as => 'remove_authority_user'
  end

  # scope :wiki_informations do
  #   resources :pages do
  #     member do
  #       put 'revert'
  #       get 'histories'
  #       post 'preview', :as => 'preview'
  #     end
  #   end
  # end
  # post "wiki_informations/:id/add_authority_user" => "wiki_informations#add_authority_user", :as => 'add_authority_user'
  # delete "wiki_informations/:id/remove_authority_user" => "wiki_informations#remove_authority_user", :as => 'remove_authority_user'


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
