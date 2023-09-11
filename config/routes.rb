Rails.application.routes.draw do
  root 'user_sessions#index'
  resources :user_sessions, only: [:index, :new, :create, :destroy]
  resources :users
  resources :users do
    member do
      get :delete # adding the delete action manual, because rails doesn't give it to you.
    end
  end
end
