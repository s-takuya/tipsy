Rails.application.routes.draw do
  root to: 'top#index'

  resources :tags, only: %i(index show), param: :name
  resources :posts, except: %i(index)
  resources :users, only: %i(show)

  delete '/sign_out',             to: 'sessions#destroy', as: :sign_out
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/auth/failure',            to: 'sessions#failure'
end
