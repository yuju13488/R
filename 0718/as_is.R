#as型態轉換
as.Date("2019-07-18")
class(as.Date("2019-07-18"))

#is型態判斷
is.character("2019-07-18")
class("2019-07-18")

tmp=c(1,2,3,NA) #有遺失子
is.na(tmp) #判斷遺失子為TRUE
tmp[is.na(tmp)]
!is.na(tmp) #判斷遺失子為FALSE
tmp[!is.na(tmp)] #去除非遺失子
sum(tmp[!is.na(tmp)]) #去除遺失子並加總
