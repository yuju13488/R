#p.35最高收盤價
setwd("E:/R")
setwd("E:/R/riii")
ls()
tw2330=read.csv("./data/2330.csv",header = T)
str(2330)
tw2330$Date=as.Date(tw2330$Date)

tw2330_2017=tw2330[(tw2330$Date>='2017-01-01'&tw2330$Date<'2018-01-01'),]
max(tw2330_2017$Close)

summary(tw2330_2017$Close)

tw2330=test.data
write.table(test.data,file="test.txt",sep="")
str(tw2330)
as.Date(tw2330$Date) > "2018-03-01"
head(tw2330[,1:5])
order.tw2330=tw2330[order(tw2330$Close, decreasing = TRUE),]
order.tw2330[as.Date(order.tw2330$Date) >= "2017-01-01",]
