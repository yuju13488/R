install.packages("tidyverse")
install.packages("readr") #讀取csv套件
library("tidyverse")
setwd('E:/R/riii')
stock=read_csv('data/2330.csv',col_names = T)

#install.packages("readxl")
library(readxl)
setwd('E:/R/riii')
FinancialReport <- read_excel("./data/FinancialReport.xlsx")
#View(FinancialReport)
summary(FinancialReport)
