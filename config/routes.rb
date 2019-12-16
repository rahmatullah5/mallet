Rails.application.routes.draw do
  devise_for :teams, path: 'teams'
  devise_for :stocks, path: 'stocks'
  devise_for :users, path: 'users'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admins, path: 'admins'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
