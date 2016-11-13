
desc "Sets Up Demo Data for Hackital Demo"
task :demo_seed => :environment do

  happy_tweet_ids = [
    563536769858437121,
    381655880187797504,
    679797083713372160,
    589467525013995521,
    708719263167610880,
    538929766444068864,
    651881493824847873,
    652638999169753088,
    529930445136601088,
    666410214984392704,
    532405271373840384,
    345896517443395586,
    663577091649179648,
    517165181248761857,
    732677404636807168,
    592138036223332353,
    540620978405900288,
    566005635511754753,
    226144471702720512,
    672669799269421056,
    721927979807289344,
    373198785293598720,
    662744993187131394,
    603780030456561664,
    533840260795355137,
    664860957361971200,
    109677448072925186
  ]

  # tweets = u.tweets.where(twitter_id: happy_tweet_ids)

  # DEMO SEEDS.


  tweet = Tweet.find_by(twitter_id: 732677404636807168)
  tweet.giphy_words << "timezones"
  tweet.queue = 1
  tweet.save!

  tweet = Tweet.find_by(twitter_id: 721927979807289344)
  # :text => "\"I'm gonna fly like a bat out of hell\" - pilot of the plane I just boarded",
  tweet.giphy_words << "plane"
  tweet.queue = 2
  tweet.save!

  tweet = Tweet.find_by(twitter_id: 708719263167610880)
  # :text => "Apply to speak @campuskitchens Summit &amp; share best practices on hunger, nutrition ed or fundraising! https://t.co/upTF1PijjA   #FWHS2016",
  tweet.queue = 3
  tweet.giphy_words << "fundraising"
  tweet.save!

  tweet = Tweet.find_by(twitter_id: 679797083713372160)
  # :text => "@michaelkpate @nationaljournal @ron_fournier aw awesome!",
  tweet.queue = 4
  tweet.giphy_words << "awesome"
  tweet.save!

  tweet = Tweet.find_by(twitter_id: 679797083713372160)
  # :text => "@michaelkpate @nationaljournal @ron_fournier aw awesome!",
  tweet.queue = 5
  tweet.giphy_words << 'awesome'
  tweet.save!

  tweet = Tweet.find_by(twitter_id: 672669799269421056)
  # "This headline could have been about Android OS lol https://t.co/ASURnUlGQS",
  tweet.giphy_words << "Android"
  tweet.queue = 6
  tweet.save!

  happy_tweets = [
    {
      :text => "I can't believe how many people are showing support for @MEANSDatabase  in the #WomenofWorth campaign! https://t.co/CmdaO4bpoM over 13k!!",
      :queue => 8,
      :giphy_words => ["Women of Worth"],
      :twitter_id => 666410214984392704
    },
    {
      :text => "NICE! https://t.co/XzbXpJBjAo",
      :queue => 9,
      :giphy_words => ["NICE!"],
      :twitter_id => 664860957361971200
    },
    {
      :text => "This is great stuff https://t.co/9N8pHybe1D",
      :queue => 10,
      :giphy_words => ["great"],
      :twitter_id => 663577091649179648
    },
    {
      :text => "Just voted for @MissMariaRose and @MEANSDatabase to win 25K. If you haven't voted today, here's the link: https://t.co/tw8YhvP2kS",
      :queue => 11,
      :giphy_words => ["voted"],
      :twitter_id => 662744993187131394
    },
    {
      :text => "Awesome https://t.co/2eCIA0Qwx2",
      :queue => 12,
      :giphy_words => ["Awesome"],
      :twitter_id => 651881493824847873
    },
    {
      :text => "Excellent :)  https://t.co/iz4ysECLnx",
      :queue => 13,
      :giphy_words => ["Excellent"],
      :twitter_id => 603780030456561664
    },
    {
      :text => '\"Dont be a jerk\" part is great. https://t.co/Pg6yIga8hV',
      :queue => 14,
      :giphy_words => ["dont be a jerk"],
      :twitter_id => 592138036223332353
    },
    {
      :text => "@RobbenOfficiaI is the best actor I've ever seen. Like Oscars need to look at him.",
      :queue => 15,
      :giphy_words => ["Oscars"],
      :twitter_id => 563536769858437121
    },
    {
      :text => "Listening to Jay-Z all day. Happy Birthday Mr. Carter.",
      :queue => 16,
      :giphy_words => ["Jay-Z"],
      :twitter_id => 540620978405900288
    },
    {
      :text => '@JosephDNelson \"I forgot to take my computer to Computer Science class today\" college boy making the fam proud',
      :queue => 17,
      :giphy_words => ["computer"],
      :twitter_id => 373198785293598720
    },
    {
      :text => "Maad city is an amazing song. Kendrick's flow perfectly complements the already great beat.",
      :queue => 18,
      :giphy_words => ["Kendrick"],
      :twitter_id => 345896517443395586
    },
    {
      :text => "TI defends his title of quickest return-to-federal-custody. Good job King.",
      :queue => 19,
      :giphy_words => ["return-to-federal-custody"],
      :twitter_id => 109677448072925186
    }
  ]

  happy_tweets.each do |hash|
    tweet = Tweet.find_by(twitter_id: hash[:twitter_id])
    tweet.queue = hash[:queue]
    tweet.giphy_words = hash[:giphy_words]
    tweet.save!
  end

  # Add GIFs to tweets
  u = User.find_by(uid: 93700710) # Grant.
  u.add_gifs_to_tweets
end


desc "Resets Hackital Demo"
task :demo_reset => :environment do
  Tweet.update_all(seen: false)
end

desc "HARD Resets Hackital Demo"
task :demo_reset => :environment do
  User.delete_all
  Tweet.delete_all
end
