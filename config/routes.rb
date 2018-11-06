Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  get   'users/:id'   =>  'users#show'
  resources :posts
end
