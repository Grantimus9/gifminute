class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :text
      t.boolean :retweet
      t.datetime :tweeted_at
      t.integer :tweeted_at_unix
      t.string :twitter_id
      t.string :giphy_words # Serialize as an array.
      t.integer :queue # From the API how the tweet ranks relative to users other tweets.
      t.boolean :seen, default: false # Whether user has seen this tweet yet.
      t.string :gif_img_url, default: "https://media.giphy.com/media/13bA2eQ0StNCAE/giphy.gif" # URL to use for img.
      t.integer :user_id # belongs to a user.
      t.timestamps
    end
    add_index(:tweets, :user_id)
  end
end
