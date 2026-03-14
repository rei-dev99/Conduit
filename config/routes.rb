Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'

  root "articles#index"
  resources :articles

  get "/articles", to: "articles#index"
  get "/articles/:id", to: "articles#show"
  get "up" => "rails/health#show", as: :rails_health_check
end
