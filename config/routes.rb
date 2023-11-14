Rails.application.routes.draw do
  root 'user_sessions#new'
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users do
    get 'users/confirm_email/:id/:confirmation_token', to: 'users#confirm_email', as: 'confirm_email', on: :member
    get 'users/update_role/:id', to: 'users#update_role', as: 'update_role', on: :member
    resources :journals do
      get 'download', on: :member
    end
    resources :tasks
  end
end
