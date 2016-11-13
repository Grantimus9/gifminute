source 'https://rubygems.org'

ruby '2.3.0'

gem 'puma', '~> 3.0' # Puma for app server

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc1', '< 5.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
gem 'sass-rails', '~> 5.0'
gem 'font-awesome-sass', '~> 4.6.2' # pulls in font-awesome for icons
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'bootstrap', '~> 4.0.0.alpha3.1'
gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'omniauth', '~> 1.0'
gem 'omniauth-twitter'
gem 'twitter', '~> 5.0' # Twitter Client.
gem 'figaro' # puts env variables in config/application.yml
gem 'roadie-rails' # inlines style for emails
gem 'sidekiq' # background workers
gem 'sinatra', :require => nil #required for Sidekiq monitoring panel.
# gem 'appsignal' # For monitoring and error reporting
gem 'httparty' # MAKES HTTP FUN AGAIN
# gem 'cancancan' # Basic permissions
# gem 'filterrific' # for filtering/searching books available.
gem 'will_paginate' # for paginating across multiple pages.
gem 'rack-timeout' # kills requests that last too long - see config/initializers/timeout.rb


group :development do
  # gem 'spring'
  gem 'better_errors'
  gem 'byebug'
  gem 'binding_of_caller'
  gem 'hub', :require=>nil
  gem 'rails_layout'
  gem 'letter_opener'
  gem 'awesome_print'
  gem 'listen', '~> 3.0.5'
  gem 'spring' # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'byebug'
end

group :production do
  # gem 'puma_worker_killer' # configure to save memory overruns
  gem 'rails_12factor'
  gem 'thin'
  gem 'heroku_rails_deflate' #gzipper for Heroku, reduces pageload time and makes Google happy
end


# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
