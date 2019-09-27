days<-c("Mon","Tue","Wed","Thu","Fri")
temp<-c(22.2,21,23,24.3,25)
rain<-c(T,T,F,F,T)
df<-data.frame(days,temp,rain)
class(df) #資料型態
str(df) #架構
summary(df) #資料摘要

data("iris")
data(iris)
class(iris)
tail(iris)
tail(iris,10)
iris[1:3,] #篩選row資料
iris[1:3,1:3] #篩選row及col資料
iris[1:3,"Sepal.Length"] #篩選col欄位關鍵字資料

setosa.data=iris[iris$Species=="setosa",1:5] #條件篩選
head(setosa.data)
which(iris$Species=="setosa") #符合條件的index

flower.type=data.frame(Species="setosa",Flower="iris")
merge(flower.type,iris[1:3,],by="Species")

order(iris$Sepal.Length,decreasing = T)
iris[order(iris$Sepal.Length,decreasing = T),][1:5,]
