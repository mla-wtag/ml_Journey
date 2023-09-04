Rails.application.routes.draw do
  root "users#index"
  resources :users
  resources :users do
    member do
      get :delete # adding the delete action manual, because rails doesn't give it to you.
    end
  end
end
