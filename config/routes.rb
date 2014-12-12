Rails.application.routes.draw do
  resources :players, only: [:index, :show]
  resources :matches, except: [:destroy]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'players#index'
end
