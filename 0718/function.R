# return預設回傳最後一行
# setwd("E:/R/riii/data")
# filename='match.txt'
# test.data=read.table(filename,header = F,sep='|')
# test.data #data.frame
# data=list(test=c(test.data[,"V3"]))
# data$test[3]
# mat=matrix(-1,nrow = 5,ncol = 5)
# k=1
# for(i in 1:5){
#   for(j in 1:5){
#     if(i != j){
#     mat[i,j]=(data$test[k])
#     k=k+1
#     }
#   }
# }
# colnames(mat)=c(levels(test.data[,"V2"])) #改變行名稱為V1欄位階層
# rownames(mat)=c(levels(test.data[,"V1"]))
# mat

match_func=function(filename='match.txt'){
  test.data=read.table(filename,header = F,sep='|') #讀取檔案資料並不排除欄位（header=F）
  row=levels(test.data[,"V1"]) #列階層A~E
  col=levels(test.data[,"V2"]) #行階層A~E
  data=list(test=c(test.data[,"V3"])) #以data.frame建立list
  mat=matrix(-1,nrow = length(row),ncol=length(col)) #重複25個1建立矩陣
  rownames(mat)=c(row)
  colnames(mat)=c(col) #改變行名稱為V1欄位階層5
  k=1 #定義k
  for(i in 1:length(row)){ #V1欄位階層長度的終值
    for(j in 1:length(col)){
      if(i != j){
        mat[i,j]=(data$test[k]) #取得list中data.frame（test.data）的值
        k=k+1 #k=1~25
      }
    }
  }
}
mat

match_func2 = function(filename,header=F,sep='|'){
  match_df = read.table(filename,header = header,sep=sep)
  mat = matrix(data=-1,nrow=length(levels(match_df[,1])),ncol=length(levels(match_df[,2])),dimnames = list(levels(match_df[,1]),levels(match_df[,2])))
  for(i in 1:nrow(match_df)){
    mat[match_df[i,1],match_df[i,2]] = match_df[i,3]
  }
  mat
}
mat

