#2019.10.01
rm(list=ls())

install.packages('ggplot2')
library(ggplot2)

ggplot(data = diamonds, aes(x=carat, y=price)) + geom_point(aes(colour=clarity))
#geom_point :산점도를 그리는 함수

######### r data 타입##########

#numeric
x=5
mode(x) #내부 데이터 타입 확인 
class(x) #데이터 전체 구조 
x <- matrix(1:10, 2)
mode(x)
class(x)

#왜 벡터의 class는 numeric으로 뜨는가/???

#날짜형 데이터 
date() #미국형식이를 표준 
#외부 한국식 날짜를 불러오면 문자열로 인식.
d1 <- c("2019/10/1")
class(d1) #character
d2<- as.Date(d1)
class(d2) #Date 

d3 <- c('01-10-2019')
d4 <- as.Date(d3)
d4 #01을 년 10을 월 2019를 일로 인식

d5 <- as.Date(d3, format = '%d-%m-%Y') #Y는 대문자로 입력 
d5 #제대로 인식 

#%y일 경우 2020년으로 뜸... why?

# 팩터 
data <- c("a", "b", 'c','c','b','a')
mode(data)
factor(data, order = T) #order는 레벨을 오름차순으로 
factor(data, levels = c("a", "c", "b")) #레벨의 순서를 직접 지정 
factor(data, labels = c("factor a", "factor b", "factor c")) #levels의 이름 직접 지정 

#null NA
#null은 공간은 있지만 값이 없음
#NA 값이 없는 상태, 지정한 범주를 넘어섬 null과 다르게 불가용

rm(list=ls())

sum(2, 4, 6)
sum(NULL, 2, 6) #null을 무시하고 8의 값을 출력
sum(NA, 1,2)# NA

a<- c(2, NA, 4)
sum(a) #NA
is.na(a) #NA있는 위치 TRUE, 아님 FALSE
sum(a, na.rm=TRUE) #NA는 지움 


#############자료구조##############
#Str() 복합 데이터 셋의 자료구조와 데이터 타입을 한번에 보여줌
#자료구조 : 데이터를 담아내는 공간
#데이터 타입 혼용 불가능:c(), matrix()
#인덱스 1부터 시작

x  = c(1:10)
x
y = seq(1, 10,by=3) #1부터 10까지 3씩 증가 
y
z = rep(y,times= 2) #y를 2번씩 
z
a=rep(y, each =2) #times는 전체적으로 반복, each는 각각 반복
a

#인덱스 
x[5] #인덱스가 5인 값 출력
x[-5] # 인덱스가 5인 값을 제외하고 출
b = c(10, 20, 30, 40, 50)
names(b)  = c('a' ,'b','d','e','r') #인덱스를 직접 지정
b['r']

x1 = c(1,3,5,7,9)
x2 = replace(x1, c(1,3) , c(10, 15)) #바꾸고 싶은 데이터, 인덱스, 바꾸고 싶은 값 
x2

x3 = append(x1,x2) #합치기 
x3
#append와 cbind 차이

##문제##
vec2 = rep(seq(1,10, by = 3), 3)
vec2

####행렬#####
A <- matrix(1:6, nrow=2) 
A #열부터 채워짐
matrix(1:6, ncol=2) #nrow가 default
matrix(1:6, 2,byrow=T) #행부터 채움 
matrix(1:6, 4) #부족한 부분은 다시 처음 숫자부터 채워짐.

mt = matrix(1:12, ncol=3)
mt
mt[1,] #행
mt[,2] #열 
mt[3,2]

a=matrix(c(70, 85, 93, 100, 78, 63), 3, byrow = T, dimnames = list(c('JP', 'YS', 'DJ'), c('Eng', 'Math')))
a #dimnames는 행 열의 이름을 지정해줌 

####배열####
ary = array(1:2, c(2,3,4)) #원소는 1과 2만으로 채운다. 2행 3열을 4개로 :3차원 
ary      


#####데이터 프레임 #####
#데이터 타입 혼용 가능
student = data.frame(a = c('a','b','c','d','e','f'),
                     b = c('m','f','m','f','f','f'), 
                     c= c(12, 34, 54 ,34,23,64))
student
student$d = c('p','f','r','e','s','s')
student$a
colnames(student) = c('NAME', 'GENDER', 'SCORE1','PASS') #chain의 이름을 변경 
#행 이름은 rownames로 변경
student
mean(student$SCORE1) #score1의 평균 계사
score = data.frame(name = c('Lee','Choi', 'PARK', 'KIM','YOU'), eng = c(93, 73, 83,73, 88))
score$math = c(100, 80, 77, 93, 60)산
mean(score$math)

####리스트#######
#key와 value 
member = list(name ='yoosin', address = 'seoul', tel = '000-0000-0000', pay =300)
member$address
member$birth = '1999-99-29'
member$addres = c('jinju','korea')
member
