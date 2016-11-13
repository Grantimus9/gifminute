class StaticpagesController < ApplicationController
  skip_before_filter :check_logged_in_status, only: [:index]

  def index
    if current_user
      @series = [
        { :name => "Tweet Download Progress", :value => current_user.download_tweet_progress_percent },
        { :name => "Tweet Analysis Progress", :value => current_user.tweet_analysis_progress},
        { :name => "Tweet GIF-ification Progress", :value => current_user.tweet_gif_progress}
      ]
    end
  end
end
