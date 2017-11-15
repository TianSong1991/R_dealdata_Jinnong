#清楚环境变量
rm(list = ls())

#加载所需要的包
library(tidyr)
library(dplyr)
library(data.table)
library(readr)
library(readxl)
library(rJava)
library(xlsxjars)
library(xlsx)
library(devtools)
library(stringr)

#设置路径
setwd('C:\\Users\\Administrator\\Desktop\\crawl\\phonebind')

#显示路径下所有文件
dir()

#读入文件
test1 <- read.csv(dir()[1])

num1 =length(dir())

for(i in 2:num1){
  test2 <- read.csv(dir()[i])
  test1 <- rbind(test1,test2)
}

test3 <- read.csv('C:\\Users\\Administrator\\Desktop\\crawl\\binddata\\phone.csv')
test <- rbind(test1,test3)

result <- data.frame(test$phone)

write.csv(result,'山东村委电话.csv')
num2 <- nrow(test1)

#读取第一个文件,转化为data.frame格式
data1 <- strsplit(test1$phone[1],split = '\n\n')

data1 <- data.frame(data1)

colnames(data1) <- c('phone')

#进行for循环用\n\n进行分割
for(i in 2:num2){
  
  data2 <- strsplit(test1$phone[i],split = '\n\n')
  
  data2 <- data.frame(data2)
  
  colnames(data2) <- c('phone')
  
  data1 <- rbind(data1,data2)
}

#转化为字符型
data1$phone <- as.character(data1$phone)

#模糊匹配
result <- data1$phone[which(grepl(pattern = '0',data1$phone))]

#转化为data.frame格式
result <- data.frame(result)

#重新赋值列名
colnames(result) <- c('phone')

write.csv(result,'resultphone.csv')
