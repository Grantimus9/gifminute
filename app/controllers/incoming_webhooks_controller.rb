class IncomingWebhooksController < ApplicationController

  # Skip cancancan authorization check for this controller.
  # skip_authorization_check

  # Skip Rails' check for authenticity tokens
  skip_before_action :verify_authenticity_token
  skip_before_action :check_logged_in_status

  # Handles incoming JSON from the ML API endpoint.
  def processed
    incoming_body = request.body
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # if application/x-www-form-urlencoded
      data = params.as_json
    end

    # Process the Dat.
    ProcessSortedTweetsWorker.perform_async(data)

    render nothing: true
  end




end
