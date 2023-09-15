Rails.application.routes.draw do
  root 'user_sessions#new'
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users
end
