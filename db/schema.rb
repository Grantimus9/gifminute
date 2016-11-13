# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161112195746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tweets", force: :cascade do |t|
    t.string   "text"
    t.boolean  "retweet"
    t.datetime "tweeted_at"
    t.integer  "tweeted_at_unix"
    t.string   "twitter_id"
    t.text     "giphy_words"
    t.integer  "queue",           default: 100000
    t.boolean  "seen",            default: false
    t.string   "gif_img_url",     default: "https://media.giphy.com/media/13bA2eQ0StNCAE/giphy.gif"
    t.integer  "user_id"
    t.datetime "created_at",                                                                         null: false
    t.datetime "updated_at",                                                                         null: false
    t.index ["user_id"], name: "index_tweets_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.bigint   "uid"
    t.integer  "followers_count"
    t.integer  "tweet_count"
    t.string   "token"
    t.string   "secret"
    t.datetime "expires_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["uid"], name: "index_users_on_uid", using: :btree
  end

end
