Rails.application.routes.draw do
  resources :player, only: [:index, :show]
  resources :match, only: [:index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'player#index'
end
