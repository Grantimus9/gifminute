Rails.application.routes.draw do

  root 'staticpages#index'

  resource :users, only: [:show] do
  end

  # Authentication
  get '/auth/:provider/callback', to: 'sessions#create' # Omniauth callback sends to sessions#create with auth hash.
  # /auth/facebook to send user to auth with fb
  # /auth/google_oauth2 to send user to auth with google
  get '/logout', to: 'sessions#destroy'

  mount_griddler('/incoming/r8hrg8as9j') # The endpoint Sendgrid sends POST data to. Relatively random.
end
