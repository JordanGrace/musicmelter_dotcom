Musicmelter::Application.routes.draw do
  
  resources :users


   get "coupon/validate"

  devise_for :admin_users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'


  get "terms/refund"
  get "terms/privacy"
  get "terms/privacy/user", controller: :terms, action: :user_privacy

  match "thankyou", controller: :thankyou, action: :index
  match "thankyou/user", controller: :thankyou, action: :user

  resources :business_accounts, only: [:create, :show, :new, :update, :index] do
    resources :payment
  end
  resources :payment, only: [:create, :index, :update, :show] do
		get :success
		get :cancel
		post :notify	
  end
  match "payment/:id/success", controller: :payment, action: :success
  match "payment/:id/cancel", controller: :payment, action: :cancel

  resources :users, only: [:create, :index, :update, :show]
  get "signup/business"
  get "signup/user"
  get "register/business"
  get "register/user"

  get '/' => 'signup#user', :constraints => { :subdomain => 'www' }
  match '/' => "signup#business", :constraints => { :subdomain => 'business' }
  
  root :to => "signup#user"

end
