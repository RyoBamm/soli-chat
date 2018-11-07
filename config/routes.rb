Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  get   'users/:id'   =>  'users#show'
  resources :posts do
    resources :comments, only: [:show, :create, :edit, :update, :destroy]
    resources :likes, only: [:create, :destroy]
  end
end
