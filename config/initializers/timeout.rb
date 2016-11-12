# Sets the timeout for HTTP requests. Heroku's router automatically kills requests
# after 30 seconds but there's no way our app knows Heroku killed it upstream.
Rack::Timeout.timeout = 25  # seconds
