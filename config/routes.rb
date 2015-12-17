Rails.application.routes.draw do
  root to: "home#home"

  get "/auth/twitter", as: :login
  get "/auth/twitter/callback", to: "sessions#create"

  get "/feed", to: "tweets#index"
  get "/compose-tweet", to: "tweets#new"
  post "/create-tweet", to: "tweets#create"

  get "/logout", to: "sessions#destroy"

  resources :user, only: :show
end
