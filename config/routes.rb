Dining::Application.routes.draw do
  require 'resque/server'

  resources :events do
    resources :reservations, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :users do
    resources :credit_cards#, only: [:new, :create, :destroy]
  end
  
  resources :landing, only: [:index]
  resources :sessions, only: [:create, :destroy]

  root to: "users#show"
  
  get 'welcome', to: 'landing#welcome', as: 'welcome'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'filter_by_region', to: 'events#filter_by_region'
  get 'subscription_confirmed', to: 'landing#subscription'
  get 'host_application', to: 'users#host_application'
  post 'send_host_application', to: 'users#send_host_application'
  get 'terms_and_conditions', to: 'landing#terms'

  mount Resque::Server.new, at: "/resque"
end
