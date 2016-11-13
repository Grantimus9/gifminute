class LoadTweetsWorker
  include Sidekiq::Worker

  # To call this: LoadTweetsWorker.perform_async(param, param, param)
  def perform(user_id)
    User.find(user_id).load_and_save_user_tweets
  end

end
