Rails.application.routes.draw do
  apipie
  root to: redirect("/homepage")

  get "/homepage", to: "homepage#homepage", as: :homepage

  devise_for :users

  # Custom named authentication routes
  # devise_scope :user do
  #   get "/sign_in",  to: "devise/sessions#new",       as: :sign_in
  #   get "/sign_up",  to: "devise/registrations#new",   as: :sign_up
  #   delete "/sign_out", to: "devise/sessions#destroy", as: :sign_out
  # end
  # Versioned API V1 Routes
  namespace :api do
    namespace :v1 do
      resources :users, only: [ :index, :show, :create, :update ,:destroy]
    end
  end
end
