Rails.application.routes.draw do
  root "welcome#index"
  devise_for :users

  resources :projects do
    member do
      put :archive
    end
    resources :tasks do
      member do
        put :move
      end
    end
  end

  resources :comments, only: %i[index create]

  get 'dashboard', to: 'users#dashboard'

  namespace :api do
    namespace :v1 do
      post 'login', to: 'sessions#create'
    end
  end
end
