Pienkowski::Application.routes.draw do
  get "posts/index"
  get "posts/new"
  root 'guest/test#index'

  namespace :user do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    get 'logout', to: 'sessions#destroy'
  end

  namespace :admin do
    root 'dashboard#show'

    resource :dashboard, controller: :dashboard, only: :show

    resources :posts
  end
end
