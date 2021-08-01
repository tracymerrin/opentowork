# -*- coding: utf-8 -*-
"""
Created on Wed Jan 20 00:01:21 2021

@author: Tracy
"""

#Importing necessary libraries
import tweepy
import csv
import pandas as pd
import datetime
import sys
from easygui import filesavebox

#setting up the API access
consumer_key="LQ3uzBUIY6Xt9MAIsdv9l6UE2"
consumer_secret="sNBL4ylBYVTsboonrbcWnnqZGnbAMDNLnomKz8jy0EATgDUCuB"
access_token="1323245452955799554-JR2kGnNRle9i41CcNfGoFhF0IzAZVt"
access_secret="gLNmh2JqyBHm4uiIPKbSR4iRhnxyI3OABkU6pYWFV26SQ"

#Authentication to login to twitter account
auth=tweepy.OAuthHandler(consumer_key, consumer_secret)

#Setting the access token and access secret
auth.set_access_token(access_token, access_secret)

#Creating the access API
api=tweepy.API(auth)

# Define Data Frame to store downloaded data
opentowork = pd.DataFrame(columns = ['Text', 'User', 'User_statuses_count','user_followers', 'User_location', 'User_verified','fav_count', 'rt_count', 'tweet_date'])


#Creating the user defined function to scrap tweets using Tweepy Library
def stream(data, file_name):
    i = 0
    for tweet in tweepy.Cursor(api.search, q=data, lang='en').items():
            print(i, end='\r')
            opentowork.loc[i, 'Text'] = tweet.text
            opentowork.loc[i, 'User'] = tweet.user.name
            opentowork.loc[i, 'User_statuses_count'] = tweet.user.statuses_count
            opentowork.loc[i, 'user_followers'] = tweet.user.followers_count
            opentowork.loc[i, 'User_location'] = tweet.user.location
            opentowork.loc[i, 'User_verified'] = tweet.user.verified
            opentowork.loc[i, 'fav_count'] = tweet.favorite_count
            opentowork.loc[i, 'rt_count'] = tweet.retweet_count
            opentowork.loc[i, 'tweet_date'] = tweet.created_at
            opentowork.to_excel('{}.xlsx'.format(file_name))
            i+=1
            if i == 500:
                break
            else:
                pass

#Calling the user defined function - stream
stream(data = ['$#lookingforwork' or '$#readytowork'], file_name = 'opentowork_data')

opentowork.to_csv(filesavebox())
