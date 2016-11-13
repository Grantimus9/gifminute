class Tweet < ApplicationRecord
  serialize :giphy_words, Array
  belongs_to :user
  before_save :assign_gif

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
  # 3. call @user.add_gifs_to_tweets to hit the GIPHY API.
  def self.process_sorted_tweets(data)

  end

  # Assign a GIF.
  def assign_gif
    if self.giphy_words.any? && self.gif_img_url == "https://media.giphy.com/media/13bA2eQ0StNCAE/giphy.gif"
      search_terms = self.giphy_words.join(' ')
      search_terms = ["happy", "awesome", "nerd", "hackathon", "lol"].sample(2).join(' ')
      gif = Giphy.search(search_terms, {limit: 1}).first
      img_url = gif.original_image.url.to_s if gif
    else
      img_url = "https://media.giphy.com/media/13bA2eQ0StNCAE/giphy.gif"
    end
    self.gif_img_url = img_url
  end

  def embed_html
    response = HTTParty.get("https://api.twitter.com/1.1/statuses/oembed.json?id=#{self.twitter_id}&hide_thread=true&align=center")
    response = JSON.parse(response.body)
    response["html"]
  end





end
