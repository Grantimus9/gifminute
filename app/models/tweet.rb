class Tweet < ApplicationRecord

  belongs_to :user

  # Given Tweet object data from Twitter, return a rails Tweet object.
  def self.normalize(raw_tweet)
    tweet = Tweet.new
    tweet.twitter_id = raw_tweet.id
    tweet.tweeted_at = raw_tweet.created_at.to_datetime
    tweet.tweeted_at_unix = raw_tweet.created_at.to_datetime.to_i
    tweet.text = raw_tweet.text
    tweet.retweet = raw_tweet.retweet?
    tweet
  end







end
