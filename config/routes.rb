Rails.application.routes.draw do
  resources :transactions, only: [:index, :create] do 
    collection do 
      get :credits
      get :withdraws
      get :withdrawals
      post :withdraw
      get :deposits
      get :deposit
      post :topup
      get :debits
      get :users
      get :teams
      get :stocks
    end
  end
  
  devise_for :teams, path: 'teams'
  devise_for :stocks, path: 'stocks'
  devise_for :users, path: 'users'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admins, path: 'admins'
  root 'transactions#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
