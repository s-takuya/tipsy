Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: %i(index)

  get '/sign_in',                 to: 'sessions#new',     as: :sign_in
  delete '/sign_out',             to: 'sessions#destroy', as: :sign_out
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/auth/failure',            to: 'sessions#failure'
end
