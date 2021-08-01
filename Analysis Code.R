# Install
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("syuzhet") # for sentiment analysis
install.packages("ggplot2") # for plotting graphs
install.packages("SentimentAnalysis")

# Load
library(tm)
library(NLP)
library(syuzhet)
library(SnowballC)
library(stringi)
library(topicmodels)
library(ROAuth)
library(dplyr)
library(ggplot2)
library(readxl)
library(SentimentAnalysis)
library(tibble)
library(topicmodels)
library(tidytext)

df= read.csv(file.choose(), encoding="UTF-8")
View(df)

# Step 1
#selecting the text column
text1 = gsub("[^A-Za-z ']", " ",df$Text)
View(text1)

# Remove punctuation
text1 <- gsub("[[:punct:]]", "", df$Text )

# Step 2: Create a corpus 
doc = VCorpus(VectorSource(text1))

# Step 3: To convert the reviews in to lowercase
doc1 = tm_map(doc, content_transformer(tolower))


# Step 4: Removing stopwords
doc2 = tm_map(doc1, removeWords, stopwords(kind = 'en'))

custom_stopwords = c('opentowork', 'looking', 'new', 'can', '2021','????httpstco6f7lxs0.', 'ani???', '???re', 'please', 'one', 'now', 'see', 'know', 'will', '<U+FFFD>re', 'next', 'time', 'much', 'just', 'also', 'ive', '<U+0001F4BC>httpstco6f7lxs0.', 'made', 'hiring<U+FFFD>', 'opentowork<U+FFFD>', 'ani<U+FFFD>', 'ashjiangwu', 'let', 'youre', 'connectio<U+FFFD>', 'httpstcocxixuictrr', 'vijaysonicollaberacom', 'jobsearch<U+FFFD>', 'mfilipe1977','ve', 'httpstc.', 'pa<U+FFFD>', 'r10d21', 'u0001f449', '<U+0001F31F>hiring')
doc3 = tm_map(doc2, removeWords, custom_stopwords)

#create DTM
DTM <- DocumentTermMatrix(doc3)
View(DTM)

dtm1 = as.matrix(DTM)

View(dtm1)

# Step 2: Convert you Matrix into a data frame containing a frequency of each word
df = sort(colSums(dtm1), decreasing = TRUE)

# Selecting topics for bigram analysis
df_new = data.frame(word = names(df), freq = df)
df_new[41,1] = "R"
#write.csv(df_new, file = "C:/Users/Tracy/Desktop/Dissertation/words.csv", 
          #row.names = FALSE)

#VIZUALIZATION USING WORD CLOUD
library(wordcloud2)
wordcloud2(df_new)

#Skillset wordcloud
skills = read.csv("C:/Users3/Tracy/Desktop/Dissertation/skills.csv")
wordcloud2(skills)

#sentiment analysis
sent <- analyzeSentiment(DTM, language = "english") 
sentiment <- sent[,1:4]
sentiment <- as.data.frame(sentiment)
summary(sentiment$SentimentGI)
summary(sentiment %>% filter(WordCount>10) %>% select(SentimentGI))

#NRC emotion lexicon for NA
na = df%>%filter(User.Continent=="North America")
emotion <- get_nrc_sentiment(na$Text)
emotion <- as.data.frame(colSums(emotion))
emotion <- rownames_to_column(emotion) 
colnames(emotion) <- c("Emotion", "Count")

dev.new(width = 1000, height = 500, unit = "px")
ggplot(emotion, aes(x = Emotion, y = Count, fill = Emotion)) + 
  geom_bar(stat = "identity") + theme_minimal() + 
  theme(legend.position="none", panel.grid.major = element_blank()) + 
  labs( x = "Emotion", y = "Total Count") + 
  ggtitle("Sentiment of #opentowork tweets in North America") + 
  theme(plot.title = element_text(hjust=0.5))

#NRC emotion lexicon for Europe
eu = df%>%filter(User.Continent=="Europe")
emotion <- get_nrc_sentiment(eu$Text)
emotion <- as.data.frame(colSums(emotion))
emotion <- rownames_to_column(emotion) 
colnames(emotion) <- c("Emotion", "Count")

dev.new(width = 1000, height = 500, unit = "px")
ggplot(emotion, aes(x = Emotion, y = Count, fill = Emotion)) + 
  geom_bar(stat = "identity") + theme_minimal() + 
  theme(legend.position="none", panel.grid.major = element_blank()) + 
  labs( x = "Emotion", y = "Total Count") + 
  ggtitle("Sentiment of #opentowork tweets in Europe") + 
  theme(plot.title = element_text(hjust=0.5))

#NRC emotion lexicon for Asia
as = df%>%filter(User.Continent=="Asia")
emotion <- get_nrc_sentiment(as$Text)
emotion <- as.data.frame(colSums(emotion))
emotion <- rownames_to_column(emotion) 
colnames(emotion) <- c("Emotion", "Count")

dev.new(width = 1000, height = 500, unit = "px")
ggplot(emotion, aes(x = Emotion, y = Count, fill = Emotion)) + 
  geom_bar(stat = "identity") + theme_minimal() + 
  theme(legend.position="none", panel.grid.major = element_blank()) + 
  labs( x = "Emotion", y = "Total Count") + 
  ggtitle("Sentiment of #opentowork tweets in Asia") + 
  theme(plot.title = element_text(hjust=0.5))


#NRC emotion lexicon for Africa
af = df%>%filter(User.Continent=="Africa")
emotion <- get_nrc_sentiment(af$Text)
emotion <- as.data.frame(colSums(emotion))
emotion <- rownames_to_column(emotion) 
colnames(emotion) <- c("Emotion", "Count")

dev.new(width = 1000, height = 500, unit = "px")
ggplot(emotion, aes(x = Emotion, y = Count, fill = Emotion)) + 
  geom_bar(stat = "identity") + theme_minimal() + 
  theme(legend.position="none", panel.grid.major = element_blank()) + 
  labs( x = "Emotion", y = "Total Count") + 
  ggtitle("Sentiment of #opentowork tweets in Africa") + 
  theme(plot.title = element_text(hjust=0.5))


#NRC emotion lexicon for Australia
aus = df%>%filter(User.Continent=="Australia")
emotion <- get_nrc_sentiment(aus$Text)
emotion <- as.data.frame(colSums(emotion))
emotion <- rownames_to_column(emotion) 
colnames(emotion) <- c("Emotion", "Count")

dev.new(width = 1000, height = 500, unit = "px")
ggplot(emotion, aes(x = Emotion, y = Count, fill = Emotion)) + 
  geom_bar(stat = "identity") + theme_minimal() + 
  theme(legend.position="none", panel.grid.major = element_blank()) + 
  labs( x = "Emotion", y = "Total Count") + 
  ggtitle("Sentiment of #opentowork tweets in Australia") + 
  theme(plot.title = element_text(hjust=0.5))


#NRC emotion lexicon for South America
sa = df%>%filter(User.Continent=="South America")
emotion <- get_nrc_sentiment(sa$Text)
emotion <- as.data.frame(colSums(emotion))
emotion <- rownames_to_column(emotion) 
colnames(emotion) <- c("Emotion", "Count")

dev.new(width = 1000, height = 500, unit = "px")
ggplot(emotion, aes(x = Emotion, y = Count, fill = Emotion)) + 
  geom_bar(stat = "identity") + theme_minimal() + 
  theme(legend.position="none", panel.grid.major = element_blank()) + 
  labs( x = "Emotion", y = "Total Count") + 
  ggtitle("Sentiment of #opentowork tweets in South America") + 
  theme(plot.title = element_text(hjust=0.5))


# Topic Modeling using LDA - Latent Dirichlet Allocation
freqterm <- findFreqTerms(DTM,30)
View(freqterm)

DTM <- DTM[,freqterm]
rownum <- apply(DTM,1,sum)
DTM <- DTM[rownum>0,]

lda <- LDA(DTM,k = 4,control = list(seed = 1502))
topic <- tidy(lda,matrix = "beta")
top_terms <- topic %>%
  group_by(topic) %>%
  top_n(20,beta) %>% 
  ungroup() %>%
  arrange(topic,-beta)


# Plot the Topics
plot_topic <- top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  scale_x_reordered()
plot_topic
