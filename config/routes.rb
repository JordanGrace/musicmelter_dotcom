Musicmelter::Application.routes.draw do
  
  get "coupon/validate"

  devise_for :admin_users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get "terms/refund"
  get "terms/privacy"

  match "thankyou", controller: :thankyou, action: :index

  resources :business_accounts, only: [:create, :show, :new, :update, :index] do
    resources :payment
  end


  get "signup/business"
  get "signup/user"
  get "register/business"
  get "register/user"
  get "user/index"

  match '/' => 'user#index', :constraints => { :subdomain => 'www' }
  match '/' => "signup#business", :constraints => { :subdomain => 'business' }

  root :to => "user#index"

end
