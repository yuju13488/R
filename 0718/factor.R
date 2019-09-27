temp=c("L","H","H","M","L","M")
temp_category=factor(temp,order=T,levels = c("L","M","H")) #加上順序關係
temp_category
temp_category[3] > temp_category[1]
levels(temp_category)=c("Low","Medium","high") #透過更改levels名稱也替換factor名稱
temp_category