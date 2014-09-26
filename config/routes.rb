Pienkowski::Application.routes.draw do
  get 'test', to: 'guest/test#index'
  post 'test', to: 'guest/test#index'

  get 'test/*path/:filename', to: 'guest/test#resource'

  root to: 'guest/posts#index', category_text_id: 'blog'

  namespace :guest, path: '' do
    scope path: ':category_text_id', constraints: {category_text_id: /(blog|articles|projects|gallery)/} do
      get '', to: 'posts#index', as: 'posts'
      get ':id(/:title)', to: 'posts#show', as: 'post'
    end
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

    resources :directories, except: [:new, :show], shallow: true do
      resources :resources
    end
  end
end
