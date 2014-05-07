Pienkowski::Application.routes.draw do
  root 'guest/test#index'

  namespace :user do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    get 'logout', to: 'sessions#destroy'
  end

  namespace :admin do
    root 'dashboard#show'
    resource :dashboard, controller: :dashboard, only: :show
  end
end
