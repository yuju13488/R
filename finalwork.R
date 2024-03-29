#(1) 請讀取final資料夾下的lvr_prices檔案 [5分]
load('D:/R/lvr_prices.RData')

#(2) 請問可使用哪個函式觀看檔案的資料結構？[5分]
str(lvr_prices) #class() 資料型態

#(3) 請問可使用哪個函式觀看資料前10筆資料？[5分]
head(lvr_prices,10)

#(4) 請篩選出
# 1. city_land_type為住宅用
# 2. total_price > 0
# 3. building_sqmeter > 0
# 4. finish_ymd 非空值
# 的房屋資料,並存入house變數中。[8分]
class(lvr_prices)
house = lvr_prices[lvr_prices$city_land_type == '住' & lvr_prices$total_price > 0 & lvr_prices$building_sqmeter > 0 & as.integer(lvr_prices$finish_ymd) !=1,]
setwd('D:/R')
save(x=house,file='house.RData')

#(5) 請使用house資料，利用房屋價格(total_price)及房屋平方米數(building_sqmeter)兩欄位，
# 產生一新欄位為每平方米價格(price_per_sqmeter)，並將其四捨五入到整數位。[5分]
house$price_per_sqmeter = round(house$total_price*house$building_sqmeter)

#(6) 請使用house資料，利用scale() 將每平方米價格(price_per_sqmeter)欄位資料標準化
#    ，並剔除掉outlier資料(z-score > 3)。[5分]
house = house[abs(scale(house$price_per_sqmeter)) <= 3,]
scale(house$price_per_sqmeter)

#(7) 請問在house資料中各行政區(area)的資料筆數為何? 可否畫出其長條圖? [5分]
library(ggplot2)
nrow(as.data.frame(house$area))
g <- ggplot(house,aes(x=area))
g+geom_bar()

#(8) 請使用house資料，計算各行政區每平方米價格(price_per_sqmeter)欄位資料的平均數，中位數及標準差 [8分]
library(plyr)
ddply(house,.(area),function(sub){data.frame(mean=mean(sub$price_per_sqmeter))})
ddply(house,.(area),function(sub){data.frame(median=median(sub$price_per_sqmeter))})
ddply(house,.(area),function(sub){data.frame(sd=sd(sub$price_per_sqmeter))})

#(9) 請使用house資料,利用ggplot2的facet_wrap函數繪製各行政區房屋每平方米價格(price_per_sqmeter)的直方圖 [8分]
g <- ggplot(house,aes(x=price_per_sqmeter))
g+ geom_histogram()+facet_wrap(~area)

#(10) 試利用房屋完工日期(finish_ymd)產生一新變數為屋齡(building_age)加入house資料中。
#hint1: 取得當前日期的函數為 Sys.Date()
#hint2: 一年請以365天計算，四捨五入至整數位
#hint3: 將運算完的資料轉為整數型態(integer) [8分]
library(lubridate)
age = round((as.integer(Sys.Date())-as.integer(ymd(house$finish_ymd)))/365)
house$building_age=age

#(11) 讀取final資料夾下的house_danger檔案，
#     並將house資料集和house_danger資料集以left outer join方式join起來，
#     存回house變數中 [5分]
load('D:/R/riii/final/house_danger.RData')
house = merge(house, house_danger, by.x="ID", by.y="ID", all.x=TRUE) 

#(12) 請將house資料以8:2的比例分為訓練集和測試集，
#     將訓練集資料存在trainset變數中，將測試集資料存在testset變數中。 [5分]
ind<-sample(1:2, size=nrow(house), replace=T, prob=c(0.8, 0.2))
trainset=house[ind==1,]
testset=house[ind==2,]

#(13) 利用rpart套件建立一預測房屋是否為危樓(danger)的決策樹模型，
#     請利用行政區(area), 屋齡(building_age), 房屋總平方米數(building_sqmeter),
#     房屋類型(building_type)及每平方米價格(price_per_sqmeter)
#     5個變數作為解釋變數放入模型當中建模，並將模型存在house.rp變數中。 [5分]
library('rpart')
con = rpart.control(minsplit=20,cp=0.01)
house.rp<-rpart(danger ~ area+building_age+building_sqmeter+building_type+price_per_sqmeter, data=trainset,control = con)

#(14) 請利用plot()和text()畫出house.rp模型的決策樹 [5分]
plot(house.rp, uniform=TRUE,branch = 0.6, margin=0.1)
text(house.rp, all=TRUE, use.n=TRUE, cex=0.7)

#(15) 請問此決策數是否需要進行剪枝(prune)？如需剪枝請將修剪後的模型存回house.rp中。 [5分]
min_row = which.min(house.rp$cptable[,"xerror"])
house.cp = house.rp$cptable[min_row, "CP"]
prune.tree=prune(house.rp, cp=house.cp)
house.rp=prune.tree

#(16) 請將測試集資料(testset)放入模型中進行驗證，請問此模型的accuracy, precision, recall等績效分別為何？ [5分]
library(caret)

