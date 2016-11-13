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

  # data is the JSON of the response we get from our ML API.
  # This method is called by a bg worker to process it.
  # It will need to:
  # 1. use the batch_id param to link it to the correct user.
  # 2. get a GIF from GIPHY using the giphy_words array.
  def self.process_sorted_tweets(data)

  end

  #
  def assign_gif

  end





end
