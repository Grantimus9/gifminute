class StaticpagesController < ApplicationController
  skip_before_filter :check_logged_in_status, only: [:index]

  def index
  end
end
