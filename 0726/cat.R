for(i in 1:9){
  for(j in 1:9){
    if(i<=j){cat(i*j,'\t') #cat可同時印文字、數字和指令
      }
  }
  cat('\n')
}

mat=matrix(rep(1,9^2),nrow = 9) #重複9^2個1
mat=matrix(data = 0,nrow = 9,ncol = 9) #重複都是0
for(i in seq_len(nrow(mat))){
  for(j in seq_len(ncol(mat))){
    mat[i,j]=sprintf("%s*%s=%s",i,j,i*j) #類似format
  }
}
mat

mat1=matrix(1:9,ncol = 1)
mat2=matrix(1:9,nrow = 1)
mat=mat1%*%mat2
mat
