Rails.application.routes.draw do
  resources :employers
  get '/verified', to: 'employers#random'
  # get 'home/index', to: 'home#index'
  # root 'home#index'
  root 'employers#index'
  get 'employers/index', to: 'employers#index'
end
