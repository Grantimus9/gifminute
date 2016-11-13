class ProcessSortedTweetsWorker
  include Sidekiq::Worker

  # To call this: ProcessSortedTweetsWorker.perform_async(param, param, param)
  def perform(data)
    Tweet.process_sorted_tweets(data)
  end

end
