install.packages("devtools")
install.packages("tidyRSS")
install.packages("XML")
install.packages("RCurl")
install.packages("plyr")
install.packages("wordcloud")
install.packages("wordcloud2")
install.packages("RColorBrewer")
install.packages("RCurl")
install.packages("bitops")

library(tidyRSS)
library(XML)
library(RCurl)
library(jiebaR)
library(stringr)
library(plyr)
library(wordcloud)
library(wordcloud2)

library(tidyRSS)
rss_url <- 'https://udn.com/rssfeed/news/2/6649?ch=news'
rss <- tidyRSS::tidyfeed(feed = rss_url)
rss$feed_title# RSS標題
rss$feed_link# RSS超連結
rss$feed_description# 說明
rss$feed_language# 語系
rss$item_title# 文章標題
rss$item_link # 文章超連結

rss <- tidyRSS::tidyfeed(feed = rss_url)
ua <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36"
myHttpHeader <- c( "User-Agent"=ua, 
                   "accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",
                   "accept-encoding: gzip, deflate, br",
                   "accept-language: zh-TW,zh;q=0.9,en-US;q=0.8,en;q=0.7,zh-CN;q=0.6",
                   "referer: https://udn.com/news/breaknews/1",
                   "upgrade-insecure-requests: 1",
                   "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36"
                   )

curl_handle <- getCurlHandle()
curlSetOpt(.opts=list(myHttpHeader),cookiejar="cookies.txt",  useragent = ua, followlocation = TRUE, curl=curl_handle,verbose=TRUE)

data <- list()
i <- 1
for( link in rss$item_link){ 
  print(paste(i,link,sep=","))
  html_doc<- htmlParse(getURL(link, curl = curl_handle), encoding = "UTF-8") 
  article_item<- xpathSApply(html_doc, '//*[@id="story_body_content"]//p', xmlValue) 
  article_item<- gsub("\\s+", "", article_item) 
  article_item<- gsub(" $", "", article_item)
  article_item<- paste(article_item,collapse = "")
  data[i] <- article_item 
  i <- i+1 
  t <- sample(2:5,1) 
  Sys.sleep(t) 
  }
data <- unlist(data)

cutter=worker(user = "E:/R/0714need.utf8",stop_word="E:/R/0714rubbish.utf8")
seq_words <- cutter <= data

library(plyr)
table_words <- count(seq_words)

library(wordcloud)
wordcloud(table_words[,1],table_words[,2],random.order = F)





