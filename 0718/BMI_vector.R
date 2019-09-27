h=hight_vec=c(180,169,173)
w=weight_vec=c(73,87,43)
BMI_vec=w/((h/100)^2)
names(BMI_vec)=c("Brian","Toby","Sherry")
BMI_vec[BMI_vec < 18.5]
BMI_vec[18.5 <= BMI_vec & BMI_vec < 24]
BMI_vec[BMI_vec >=27]

mat=matrix(data=c(h,w),nrow=3,byrow=F) #矩陣順序byrow
colnames(mat)=c("hight","weight") #改變行名稱
rownames(mat)=c("Brian","Toby","Sherry") #改變列名稱
dim(mat)
nrow(mat)
ncol(mat)
t(mat)
mat[1,]
mat[,1]
mat[1:2,] #取得第一、二列
mat[c("Toby","Sherry"),] #取得列名稱為key的value
mat[c("Toby","Sherry"),"weight"] #取得列名稱,行名稱的value
mat[mat[,2] < 75,"weight"] #取得第二行小於75
mat2=rbind(mat,c(176,80))
rownames(mat2)[nrow(mat2)]="Yoyo"
nrow(mat2)
cbind(h,w) #行合併
colSums(mat2) #行加總
colMeans(mat2) #行平均

m1=matrix(1:4,byrow = T,nrow=2)
m2=matrix(5:8,byrow = T,ncol=2)
m1 %*% m2 #矩陣相乘
