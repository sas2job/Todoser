Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root "welcome#index"
  devise_for :users

  get "about_us", to: "pages#about_us"
  get "contacts", to: "pages#contacts"

  resources :projects do
    member do
      put :archive
    end

    resources :tasks do
      member do
        put :move
        post "mark", to: "task_project_marks#create"
        delete "mark", to: "task_project_marks#destroy"
      end
    end

    put "marks", to: "project_marks#edit"

    delete "leave", to: "project_members#leave"
  end

  resources :comments, only: %i[create update destroy]

  resources :favorites, only: %i[index create]
  delete :favorites, to: "favorites#destroy"

  get 'dashboard', to: 'users#dashboard'
  put 'change_locale', to: 'users#change_locale'

  namespace :api do
    namespace :v1 do
      post 'login', to: 'sessions#create'

      resources :projects, only: %i[index show]

      resources :tasks, only: :show
    end
  end

  mount ActionCable.server, at: '/cable'
end
