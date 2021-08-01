install.packages("twitteR")
install.packages("rtweet")

library(twitteR)
library(rtweet)

consumer_key = "LRZY7Gy7AJBdtpvTJxFEwj3nm"
consumer_secret = "vkfLcuH08HWqdJ08hl1ceq5PiQza8yz6JpHJxDAYoHR3XHJuyU"
access_token = "1365569612163608576-KTibuU8DYKAslJzpTU2klKm6EUOZzJ"
access_secret = "k3lIKSXPZbJcrZIsFqxHx1FZk9mmbbQqk7TAFvMlD00aD"

options(httr_oauth_cache=F)
getOption("httr_oauth_cache")
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
hashtag = searchTwitter('#opentowork OR #OpenToWork', n = 2000)
print(hashtag)
datafile = twListToDF(hashtag)
write.csv(datafile, file = "C:/Users/Tracy/Desktop/Dissertation/raw1.csv", 
          row.names = FALSE)
