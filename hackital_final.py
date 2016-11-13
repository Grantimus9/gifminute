# -*- coding: utf-8 -*-
"""
Created on Sun Nov 13 05:06:06 2016

@author: JosephNelson
"""

# get dependencies
import pandas as pd
from textblob import TextBlob
import json
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

# read in the data
with open('grant_tweets.json', "r") as f:
  data = json.loads(f.read())

# create empty lists
text = []
date = []
tweet_id = []

# convert json data to lists then dataframe
for x in data['request']['data']:
    text.append(x['text'])
    date.append(x['tweeted_at_unix'])
    tweet_id.append(x['twitter_id'])

tweets = pd.DataFrame(
    {'date': date,
     'tweet_id': tweet_id,
     'text':text
    })

# perform sentiment analysis
def detect_sentiment(text):
    return TextBlob(text.decode('utf-8').strip()).sentiment.polarity
tweets['sentiment'] = tweets.text.apply(detect_sentiment)

# sort by sentiment
tweets.sort(columns='sentiment', inplace=True, ascending=False)

# cutoff - only work with a certain number of user tweets
# optional parameter: either use what is passed else default to 50
def get_cutoff():
    try:
        return data['request']['requested_queue_length']
    except:
        return 50
cutoff = get_cutoff()

# reset index
tweets.reset_index(inplace=True)

# determine if the request wants positive or negative tweets, default=positive
def get_pos():
    try:
        if data['request']['sort_order'] == 'positive':
            return True
        else:
            return False
    except:
        return True

# identify if positive is T/F, get sentiment list
def get_sentiment_list(tweets_list):
    positive = get_pos()
    if positive==True:
        return tweets_list.head(cutoff)
    else:
        return tweets_list.tail(cutoff)     
sentiment_list = get_sentiment_list(tweets)

# define a queue df
queue = pd.DataFrame(columns=['date', 'tweet_id', 'text'])
def build_queue(sentiment_list):
    queue.loc[len(queue)] = [sentiment_list['date'][0], sentiment_list['tweet_id'][0], sentiment_list['text'][0]]
    while queue.shape[0]<sentiment_list.shape[0]:
        queue.loc[len(queue)] = add_to_queue(queue, sentiment_list)

def add_to_queue(growing_df, sentiment_list):
    search_space = set(queue['tweet_id'].tolist()).symmetric_difference(set(sentiment_list['tweet_id'].tolist()))
    search_space = pd.DataFrame({'tweet_id': list(search_space)})
    search_space.merge(sentiment_list, how='inner')
    search_space.sort(columns='sentiment', inplace=True, ascending=False)
