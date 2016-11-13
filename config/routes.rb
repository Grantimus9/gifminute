Rails.application.routes.draw do

  root 'staticpages#index'

  resource :users, only: [:show] do
  end

  # Authentication
  get '/auth/:provider/callback', to: 'sessions#create' # Omniauth callback sends to sessions#create with auth hash.
  # /auth/facebook to send user to auth with fb
  # /auth/google_oauth2 to send user to auth with google
  get '/logout', to: 'sessions#destroy'

  # post '/incoming/'
end
