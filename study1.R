#2019.9.24
getwd()
rm(list=ls())
setwd("c:/Users/서용비/Desktop")

air = read.csv('./air_data.csv', stringsAsFactors = F)
list.files("./")

str(air)

head(air)

air$so2Value = as.numeric(air$so2Value)

air$so2Value

for (i in 4:9){
  air[,i] = as.numeric(air[,i])
}

class(air[,4])

air[3,]

#NA값이 들어있는 행을 제외하고, 4열에서 9열까지 각각의 평균을 구한 후 저장
A = c()

for (i in 4:9){
  A[i] = mean(air[,i], na.rm=T)
}
A

for (i in 4:9){
  
}