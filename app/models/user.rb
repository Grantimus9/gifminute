class User < ApplicationRecord
  has_many :tweets

  after_create :bg_load_and_save_user_tweets

  # Create a new user object based on oauth auth_hash data.
  def self.create_new_user(auth_hash)
    self.create!(
      name: auth_hash.info.name,
      provider: auth_hash.provider,
      uid: auth_hash.uid,
      tweet_count: auth_hash.extra.raw_info.statuses_count,
      followers_count: auth_hash.extra.raw_info.followers_count,
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
      options = {count: 200, include_rts: true}
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

  def bg_load_and_save_user_tweets
    LoadTweetsWorker.perform_async(self.id)
  end

  # Calls the API
  def request_sorting(queue_length: 50)
    HTTParty.post('https://hookb.in/Zdx5jYNP',
    :body => { :request => {
                :requested_queue_length => queue_length,
                :sort_order => "positive", # or "negative"
                :batch_id => self.id, # Just the user id for now.
                :token_key => "secretkeysadfdffsadoawfeowafgweafuh382uh134ijgwa",
                :data => self.tweets.select(:text, :tweeted_at_unix, :twitter_id)
                }
             }.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
  end

  # Get GIFs for each Tweet for this user.
  def add_gifs_to_tweets
    self.tweets.each do |tweet|
      tweet.assign_gif unless tweet.seen
    end
  end

  # Get the percent completed in downloading Tweets from Twitter.
  def download_tweet_progress_percent
    count = self.tweets.count
    max = [self.tweet_count, 3200].min
    ((count.to_f / max.to_f) * 100).round(2)
  end

  # Get the percent completed in getting tweets classified/sorted
  def tweet_analysis_progress
    max = self.tweets.count
    count = max - self.tweets.where(queue: 100000).count
    ((count.to_f / max.to_f) * 100).round(2)
  end

  # Get the percent completed in adding gifs to classified tweets
  def tweet_gif_progress
    max = self.tweets.count
    count = max - self.tweets.where(gif_img_url: "https://media.giphy.com/media/13bA2eQ0StNCAE/giphy.gif").count
    ((count.to_f / max.to_f) * 100).round(2)
  end

  # Get the next Tweet to show the user.
  # Tweet hasn't been seen yet.
  # Tweet in order of queue.
  # Tweet has a gif to show that's not the default gif.
  def next_tweet(sentiment: "positive")
    if sentiment == "positive"
      tweet = self.tweets.where(seen: false, retweet: false).order(queue: :asc).first
    else
      tweet = self.tweets.where(seen: false, retweet: false).order(queue: :desc).first
    end
    tweet.update_attribute(:seen, true)
    tweet
  end

  private
    def collect_with_max_id(collection=[], max_id=nil, &block)
      response = yield(max_id)
      collection += response
      response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
    end




end
