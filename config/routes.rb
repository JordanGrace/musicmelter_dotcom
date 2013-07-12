Musicmelter::Application.routes.draw do
  
  

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get "coupon/validate"

  devise_for :admin_users
  

  get "terms/refund"
  get "terms/privacy"

  match "thankyou", controller: :thankyou, action: :index

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

  get "signup/business"
  get "signup/user"
  get "register/business"
  get "register/user"
  get "user/index"

  match '/' => 'user#index', :constraints => { :subdomain => 'www' }
  match '/' => "signup#business", :constraints => { :subdomain => 'business' }

  root :to => "user#index"

end
