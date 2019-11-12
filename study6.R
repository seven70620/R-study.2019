rm(list=ls())
#####################################
######## R data processing ##########
#####################################

#dplyr패키지와 데이터 셋 hflight 설치 
if(!require(dplyr)) {install.packages('dplyr');library(dplyr)}
if(!require(hflights)) {install.packages('hflights');library(hflights)}

# 데이터 확인 
head(hflights)
str(hflights)
dim(hflights)

# tbl_df 형식으로 변환
#tbl_df() :콘솔 창의 크기만큼 데이터 셋을 추출할 수 있게 하는 함수
hflights_df <- tbl_df(hflights)
hflights_df

#######R 기본 함수 이용########
#####데이터 정리######

# dataset의 열 이름을 확인하고 'Month', 'DepTime', 'AirTime'열을 골라보자 
# 1) 각 열이 몇 번째 열인지 확인하고 dataframe 인덱싱 방법 사용 
# names(): 데이터 프레임의 열 이름을 출력하는 함수 
# match(a,b) : 첫 번째 벡터 a의 인수가 두 번째 벡터 b의 인수에 몇 번째에 있는지 위치 출력 함수 
names(hflights_df)
hflights_df[,match(c('Month', 'DepTime', 'AirTime'), names(hflights_df))]
#2) 열 이름, 문자열 벡터를 직접 입력 
hflights_df[,c('Month', 'DepTime', 'AirTime')]
#3) 데이터 프레임이 list라는 성질을 사용 
hflights_df[c('Month','DepTime', 'AirTime')]

# Month 값이 11인 데이터 행만 추출하자
hflights_df[hflights_df$Month == 11,]
# Month 값이 1, DayofMonth 값이 1인 데이터의 'DepTime' 열을 추출하자
hflights_df[hflights_df$Month==1 & hflights_df$DayofMonth==1, c('DepTime')]

# 데이터 셋에 DepTime_min열을 추가한 hflights_ex 데이터 프레임을 생성하자
# DepTime_min열은 DepTime열에 60을 곱한 값을 가진다. 
# hflights_ex 데이터 프레임에서 DepTime_min의 값이 NA인 것은 제외한다.
#1) cbind() 사용 
DepTime_min <- hflights_df$DepTime*60
hflights_ex1 <- cbind(hflights_df, DepTime_min)
hflights_ex1 <- hflights_ex[!is.na(hflights_ex),]
#2) list에서 데이터를 추가하는 방법 사용 
hflights_ex2 <- hflights_df
hflights_ex2$DepTime_min <- hflights_ex2$DepTime*60
hflights_ex2<- hflights_ex2[!is.na(hflights_ex2$DepTime_min),]

#####통계량의 계산#####

#hflights_df 데이터에서 Month 별로 AirTime의 평균을 계산하자.
#NA값은 제외하고 계산하자.
#1)
unique(hflights_df$Month)
mean(hflights_df$AirTime[hflights_df$Month == 1], na.rm=T)
mean(hflights_df$AirTime[hflights_df$Month == 12], na.rm=T)
#2)by함수 이용 
by(data=hflights_df$AirTime, INDICES = hflights_df$Month, FUN = mean, na.rm=T)
#3) aggregate 함수 이용
aggregate(formula = AirTime ~ Month , data = hflights_df, FUN = mean, na.rm=T)

# ArrDelay 와 DepDelay별로 AirTime의 평균 계산
#aggregate 함수 이용
aggregate(formula = AirTime~ArrDelay + DepDelay, data = hflights_df, FUN = mean, na.rm=T)

# hflights_df 데이터의 일, 월별 빈도를 계산
# table() 사용 
table(hflights_df$Month)
table(hflights_df$Month, hflights_df$DayofMonth)

# Month값의 오름차순으로 데이터 셋을 정렬하자
hflights_df[order(hflights_df$Month),]
#Month값을 내림차순으로 정렬하고 그 순서를 유지하면서 DayofMonth값 오름차순으로 데이터를 정렬
tmp<- hflights_df
tmp<-tmp[order(tmp$Month, decreasing = T),]
tmp 
tmp <-tmp[order(tmp$DayofMonth),]
tmp


#######dplyr 함수 이용#########
# 중요 함수 : select(), filter(), mutate(), group_by(), summarize()
# %>% :파이프라인 연산자, 각 조작은 연결해서 한 번에 수행할 수 있다.
# 단축키 ctrl + shift + M

#####데이터 정리#####
#'Month', 'DepTime', 'AirTime'열을 골라보자 
# select(): 열을 추출
# 복수의 열을 추출할 경우 콤마(,)로 구분
select(.data = hflights_df, Month, DepTime, AirTime)
select(.data = hflights_df, Month, DepTime, AirTime) %>% head()
# 인접한 열을 추출할 때에는 : 연산자 사용 가능 
select(.data = hflights_df, Year:DayOfWeek)
# 지정한 열을 제외한 나머지 열을 추출하고 싶은 경우 괄호 앞에 -부호를 붙임
select(.data = hflights_df, -(Year:DayOfWeek))

# Month 값이 11인 데이터 행만 추출하자
# filter(): 조건에 따라 행을 추출, and조건(, &), or조건(|)
filter(.data = hflights_df, Month ==11) %>% head()
# Month 값이 1, DayofMonth 값이 1인 데이터의 'DepTime' 열을 추출하자
filter(.data=hflights_df, Month==1, DayofMonth ==1) %>% head()
filter(.data=hflights_df, Month==1 & DayofMonth ==1) %>% head()

#Month 값이 1인 데이터에 대해 'ArrTime', 'DepTime'열을 골라보자
#AirTime이 NA인 것은 제외하자.
# %>% 사용
hflights_df %>% filter(!is.na(AirTime)) %>% filter(Month==1) %>% select(ArrTime, DepTime) %>% head()

# DepTime_min열을 추가하자.
# DepTime_min열은 DepTime열에 60을 곱한 값을 가진다. 
# DepTime_min의 값이 NA인 것은 제외한다.
# mutate(): 열을 추가할 때 사용 
hflights_df %>% mutate(DepTime_min = DepTime*60)%>% filter(!is.na(DepTime_min)) %>% head()

#####통계량의 계산#####

#hflights_df 데이터에서 Month 별로 AirTime의 평균을 계산하자.
#NA값은 제외하고 계산하자.
#summarize() : mean(), sd(), var(), median() 등의 함수를 지정하여 기초통계량을 구할 수 있다.
#결과 값이 데이터 프레임 형식으로 돌아오
#group_by() : 지정한 열별로 그룹화된 결과를 얻을 수 있다. 
hflights_df %>% group_by(Month) %>% summarize(mean_AirTime = mean(AirTime, na.rm=T))

# ArrDelay 와 DepDelay별로 AirTime의 평균 계산
#NA값 제외
hflights_df %>% group_by(ArrDelay, DepDelay) %>% summarize(mean_AirTime = mean(AirTime, na.rm=T))

# Month 별로 AirTime의 최대, 최소 계산
hflights_df %>% group_by(Month) %>% summarize(min_AirTime = min(AirTime, na.rm=T),max_AirTime = max(AirTime, na.rm=T)) %>% print(n=5)

# 일, 월별 빈도를 계산
# tally()
hflights_df %>% group_by(Month, DayofMonth) %>% tally()

# Month값의 오름차순으로 데이터 셋을 정렬하자
#arrange() : 지정한 열을 기준으로 작은 값부터 큰 값 순으로(오름차순) 데이터 정렬
#내림차순은 desc() 함께 사용 
hflights_df %>% arrange(Month) %>% print(n=5)
#Month값을 내림차순으로 정렬하고 그 순서를 유지하면서 DayofMonth값 오름차순으로 데이터를 정렬
hflights_df %>% arrange(desc(Month),DayofMonth ) 



