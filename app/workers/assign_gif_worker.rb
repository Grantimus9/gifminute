class AssignGifWorker
  include Sidekiq::Worker

  # To call this: AssignGifWorker.perform_async(param, param, param)
  def perform(tweet)
    tweet.assign_gif
  end

end
