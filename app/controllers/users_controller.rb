class UsersController < ApplicationController
  def index
  end

  def show
  end

  def onboard_progress_update
    user = current_user
    @series = [
      { :name => "Tweet Download Progress", :value => user.download_tweet_progress_percent },
      { :name => "Tweet Analysis Progress", :value => user.tweet_analysis_progress},
      { :name => "Tweet GIF-ification Progress", :value => user.tweet_gif_progress}
    ]
  end
end
