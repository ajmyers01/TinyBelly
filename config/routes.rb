Rails.application.routes.draw do
  resource :users, only: [:create]
  post "/login", to: "users#login"

  resources :links
  get '/s/:slug', to: 'links#show', as: :short
end
