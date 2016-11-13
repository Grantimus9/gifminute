class User < ApplicationRecord
  has_many :tweets

  # Create a new user object based on oauth auth_hash data.
  def self.create_new_user(auth_hash)
    self.create!(
      name: auth_hash.info.name,
      provider: auth_hash.provider,
      uid: auth_hash.uid,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
    )
  end

  # Returns a TWITTER object you can use to interact with Twitter via this user.
  def twitter_api
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CLIENT_ID"]
      config.consumer_secret     = ENV["TWITTER_CLIENT_SECRET"]
      config.access_token        = self.token
      config.access_token_secret = self.secret
    end
    client
  end

  def timeline
    self.twitter_api.user_timeline(self.uid)
  end

  # Gets all 3200 of the users latest tweets and returns an array of tweets.
  # This takes like 25-35 seconds to run.
  def all_user_tweets
    user = self
    user_twitter_id = user.uid
    collect_with_max_id do |max_id|
      options = {count: 200, include_rts: false}
      options[:max_id] = max_id unless max_id.nil?
      user.twitter_api.user_timeline(user_twitter_id, options)
    end
  end

  # Get Tweets from Twitter into our database.
  def load_and_save_user_tweets
    raw_tweets = self.all_user_tweets
    raw_tweets.each do |raw_tweet|
      self.tweets.find_or_create_by(twitter_id: raw_tweet.id) do |new_tweet|
        new_tweet.attributes = Tweet.normalize(raw_tweet).attributes
      end
    end
  end

  # Calls the API
  def request_sorting(queue_length: 50)
    HTTParty.post('https://hookb.in/Zdx5jYNP',
    :body => { :request => {
                :requested_queue_length => queue_length,
                :data => self.tweets.select(:text, :tweeted_at_unix, :twitter_id)
                }
             }.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
  end

  def tweets_for_classifying
    self.tweets.select(:text, :tweeted_at_unix, :twitter_id)
  end

  private
    def collect_with_max_id(collection=[], max_id=nil, &block)
      response = yield(max_id)
      collection += response
      response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
    end




end
