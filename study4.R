#통계함수 
a<-c(2,7,5,3,1,4,6)
sum(a)#합계
prod(a)#총 곱
max(a)
min(a)
diff(a) # 앞뒤 원소들간의 차이
which.max(a)#max 원소 인덱스 추출
which.min(a)
range(a) #값의 범위
mean(a)
median(a)
sd(a)
var(a)
quantile(a)
quantile(a,0.75)#원소들을 나열해서 분위수

#수학 연산 
log(a) #자연로그 
log(a, base=2)#밑을 바꾸고 싶을 때 base=
exp(a)
sqrt(a)
abs(a)
round(sqrt(a), 2)#반올림, 소수 두번째자리까지 
floor(sqrt(a))#.....?
ceiling(sqrt(a)) #.....?
cumsum(a)#누적 합
cumprod(a)#누적 곱
cummin(a)#누적 최소값
cummax(a)#누적 최대

#집합
b<-c(1,2,10)
union(a,b)#합집합
intersect(a,b)#교집
setdiff(a,b) #a-b 차집합
is.element(a,b)#a에 있는 원소가 b에 있는가 
setequal(a,b) #집합이 동일한가 
#문자열 집합도 가능
union(c("banana", "is", "mine"), c("apple", "is", "mine"))
intersect(c("banana", "is", "mine"), c('apple', 'is', 'mine'))
setdiff(c("banana", "is", "mine"), c('apple', 'is', 'mine'))

pmin(c(2,8,3),c(3,4,5),c(5,2,9))#각 벡터에서 같은 인덱스의 숫자를 비교해서 작은 값을 리턴         
min(c(2,8,3),c(3,4,5),c(5,2,9))#원소를 모두 합했을 때 
pmax()
z<-matrix(c(1,5,6,2,3,2,0,2,5), ncol=3)
min(z[,1],z[,2],z[,3])
pmin(z[,1],z[,2],z[,3])

#분포
#pdf : d
#cdf : p
#quantile : q
#randomnumbers : r 

#5개중 하나를 택하는 선다형 문제가 20문제
#(a) 정답이 하나도 없을 확률
dbinom(x=0, size =20, prob=1/5)#pdf
#(b) 8개이상의 정답을 맞힐 확률
1-pbinom(q=7,size=20, prob=1/5)#cdf
#(c) 4개 이상 6개 이하의 정답을 맞힐 확률
pbinom(q=6,size=20, prob=1/5)-pbinom(q=3, size=20, prob=1/5)

#p(z<-1.9 or z>2.1)
pnorm(q=1.9, mean = 0, sd=1)+ 1-pnorm(q=2.1, mean=0, sd=1)

#sorting
x<-c(12,5,3,9)
sort(x)#x 자체가 변하는 것은 아님. 
sort(x, decreasing=T) #내림차순 
rev(x) # 순서 거꾸로
rank(x) #해당 원소의 순위를 원래 자리에 나타냄 (오름차순)
rank(-x)#(내림차순) 
order(x)#해당 원소의 인덱스를 오름차순으로 배열 

#행렬 
a<-matrix(c(1,2,3,4),ncol=2, byrow=T)
b<-matrix(c(1,0,-1,1),ncol=2)
a%*%b #행렬곱

a<-matrix(c(1,1,-1,1), nrow=2, ncol=2)
b<-c(2,4)
d=solve(a) #역행렬
solve(a,b) #연립방정식의 해 
a%*%d #항등행렬 

t(a)#전치 
det(a)#행렬식 
eigen(a) #고유치, 고유벡터 
diag(a)#대각원소 
diag(3)#항등행렬 3by3
diag(c(1,2,3))#대각행렬의 대각원소 지정
diag(10,3,4)#대각원소가 10인 3by4행렬
svd(a)#svd분해 

m<-matrix(1:9, nrow=3, byrow=T)
m
sweep(m,1,c(1,4,7),"+")#1은 행, 2는 열, 
#1행에 1, 2행에 4, 3행에 7을 더함

s<-matrix(1:12,3,4)
s
sweep(s,2,colMeans(s)) #열별 평균으로부터의 편차. 
#행별은 1, rowMeans()로

#문자열 
nchar("South Pole")#문자의 개수 , 공백 포함 

paste("North","Pole") #문자열 붙이기 , 기본값은 띄어쓰기
paste("North","Pole",sep="-")

substring("Equator",3,5)#substr()과 동일
#start, stop, 인덱스는 3부터 5까지 추출 
strsplit("6-16-2011",split="-")#문자열 분리 
tolower("Hello")#다 소문자로
toupper("Hello")#다 대문자로 


#substr 이용하여 Today is Monday를 Sunday로 바꾸기
string_1 = "Today is Monday"
substr(string_1,10,12) <- "Sun" #원래 값에서 변환이 일어남. 
string_1

#문자열 찾기 (기본)

grep("Pole",c("Equator","North pole","South Pole"))
#패턴이 있으면 인덱스를 반환 
grepl("Pole",c("Equator","North Pole","South Pole"))
#패턴이 있으면 true, false 반환 
regexpr("Pole",c("Equator","North Pole Pole","South Pole"))
#패턴의 시작 인덱스를 반환, equator에는 없으므로 -1. 

gregexpr("Pole",c("Equator","North Pole Pole","South Pole"))
#패턴이 나타나는 모든 위치를 반환, 
#regexpr은 패턴이 처음 나타나는 위치만 반환 
#옵션 :fixed-패턴과 정확하게 맞는 경우만 출력, invert-패턴이 없는 게 출력,ignore.case-대소문자 구분 안함, value-인덱스가 아닌 값 자체를 반환 

regexec("Pole",c("Equator","North Pole","South Pole"))
#gregexpr()똑같은 함수
#옵션 : value, invert, ignore.case, fixed

#문자열 찾기 (패키지)
install.packages("stringr")
library(stringr)

fruit <- c("apple", "banana", "cherry")
str_count(fruit, "a") # 문자가 몇개씩 포함되어 있는지 
str_detect(fruit, "a") #true, false반환 
str_locate(fruit, "a")
#첫번째 문자의 인덱스 반환
str_locate_all(fruit, "a")
#들어있는 모든 문자 인덱스 반환 

people <- c("rorori", "emilia", "youna")
str_extract(people, "o(\\D)")   #\\D는 non-digit character를 의미합니다.
#o(문자) 패턴을 출력  
str_extract_all(people, "o(\\D)")
#o(문자) 패턴을 모두 찾아 줌 
str_match(people, "o(\\D)")
#o(\\D)패턴을 1열에 출력, 2열엔 (\\D)가 출력 
str_match_all(people, "o(\\D)")

str_rim("  Hello World!  ",side="both")
#공백 제거 

#문자열 찾아서 바꾸기
fruits <- c("one apple", "two pears", "three bananas")
sub("[aeiou]", "-", fruits)
#
str_replace(fruits, "[aeiou]", "-")
#
gsub("[aeiou]", "-", fruits)

str_replace_all(fruits, "[aeiou]", "-")