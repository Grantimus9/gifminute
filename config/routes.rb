Rails.application.routes.draw do

  get 'tweets/index'

  get 'tweets/show'

  root 'staticpages#index'

  resources :users, only: [:show] do
    member do
      get :onboard_progress_update
    end
    collection do
    end
  end

  resources :tweets, only: [:show, :index] do

  end

  # Authentication
  get '/auth/:provider/callback', to: 'sessions#create' # Omniauth callback sends to sessions#create with auth hash.
  # /auth/facebook to send user to auth with fb
  # /auth/google_oauth2 to send user to auth with google
  get '/logout', to: 'sessions#destroy'

  post '/incoming/processed' => 'incoming_webhooks#processed'
end
