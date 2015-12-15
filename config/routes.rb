Rails.application.routes.draw do
  root to: "home#home"

  get "/auth/twitter", as: :login
  get "/auth/twitter/callback", to: "sessions#create"
  
  get "/feed", to: "tweets#index"

  get "/logout", to: "sessions#destroy"
end
