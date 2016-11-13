class TweetsController < ApplicationController
  def index
    @tweet = current_user.next_tweet(sentiment: "positive")


  end

  def show
    @tweet = current_user.tweets.find(params[:id])
  end
end
