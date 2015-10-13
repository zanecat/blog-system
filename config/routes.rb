Rails.application.routes.draw do
  get 'messages/index'
  post 'users/new_message'
  post 'messages/delete'
  
  resources :posts
  resources :messages
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  root to: 'static_pages#home'
  match 'message', to: 'messages#index', via: 'get'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/search',  to: 'users#search',         via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  
end
