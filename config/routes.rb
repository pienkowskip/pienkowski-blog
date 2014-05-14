Pienkowski::Application.routes.draw do
  get "categories/index"
  get 'test', to: 'guest/test#index'

  root 'guest/posts#index'

  namespace :guest, path: '' do
    resources :posts, only: [:index, :show]
  end

  namespace :user do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    get 'logout', to: 'sessions#destroy'
  end

  namespace :admin do
    root 'dashboard#show'

    resource :dashboard, controller: :dashboard, only: :show

    resources :posts, except: :show
    resources :categories, except: [:new, :show], shallow: true do
      resources :posts, only: :index
    end
  end
end
