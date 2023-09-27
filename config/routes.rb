Rails.application.routes.draw do
  root 'user_sessions#new'
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users do
    get 'users/confirm_email/:id/:confirmation_token', to: 'users#confirm_email', as: 'confirm_email', on: :member
  end
end
