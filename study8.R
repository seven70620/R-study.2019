######8주차######

#상관분석
#산점도
data(cars)
plot(cars$speed, cars$dist)

#상관계수
cor(cars$speed, cars$dist)
#상관계수 pearson: 자료가 양적자료일때 사용 
# kendall, spearman: 자료가 순서형일때 

#상관분석
#h0: 두 양적자료간의 관련성이 없다.
cor.test(cars$speed, cars$dist)
#p-value<0.05이므로 유의수준 5%에서 귀무가설을 기각
#두 자료간의 상관성이 있다고 할 수 있다 


#산점행렬도
plot(iris[,1:4])
pairs(iris[,1:4])

#상관계수 행렬
cor(iris[,1:4])

# Hmisc :: rcorr()
# 여러 개의 양적자료에 대한 상관계수와 유의확률을 한꺼번에 
install.packages("Hmisc")
library(Hmisc)

test<-rcorr(as.matrix(iris[,1:4]))
test$P

# psych :: corr.test()
install.packages("psych")
library(psych)
#상관계수와 유의확률을 한꺼번에 , 행렬이 아닌 데이터프레임이 입력 값 
corr.test(iris[,1:4])

# corrplot :: corrplot() #산점행렬도 작성, 데이터프레임 입력
install.packages("corrplot")
library(corrplot)
result = cor(iris[,1:4])
corrplot(result, method = 'circle', type = 'upper')
# 절대값의 크기가 원의 크기 
corrplot.mixed(result, lower = 'circle', upper = 'number', insig = 'blank')

#옵션 참고 페이지 https://rpubs.com/cardiomoon/27080 

#------------------------------------------------------------------#

#단순선형 회귀분석 : 
df <- read.csv("http://goo.gl/HKnl74")
head(df) #놀이기구 만족도 자료 
attach(df)

# 1. 회귀식의 추정
m1 <-lm(overall~rides)
m1

# 산점도 그리기
plot(overall~rides)
abline(m1, col='blue')


# 2. 회귀모형의 검정 및 적합도 파악
summary(m1)

# 다중선형 회귀분석
m2<-lm(overall~rides+games+clean)
summary(m2)

#----------------------------------------#
# Homework 예제
car <- read.csv("C:/Users/서용비/Documents/카카오톡 받은 파일/car.csv")
head(car)

# 결측치 제거
dim(car)
car<-car[complete.cases(car), ] #결측치가 없는 행만 TRUE
dim(car)

# 가변수 생성
#lpg 범주형, 
unique(car$연료)
가솔린 <-NA
디젤 <-NA
temp<-cbind(car, 가솔린, 디젤 )

temp$가솔린[temp$연료=="가솔린"] <- 1
temp$가솔린[is.na(temp$가솔린)] <- 0
temp$디젤[temp$연료 == "디젤"] <- 1 
temp$디젤[is.na(temp$디젤)] <- 0 
#가변수 생성 

temp$가솔린 <- as.factor(temp$가솔린)
temp$디젤 <- as.factor(temp$디젤)
temp <- temp[,-8]
head(temp)

temp$년식 <- as.factor(temp$년식) 
temp$LPG <- as.factor(temp$LPG)
temp$회사명 <- as.factor(temp$회사명)
temp$종류 <- as.factor(temp$종류)
temp$하이브리드 <- as.factor(temp$하이브리드)
temp$변속기 <- as.factor(temp$변속기)

# 회귀모형 적합
fit <-lm(가격~., data = temp)
summary(fit) #모든 변수를 포함한 회귀모형. 필요없는 변수도 포함됨. 

# 변수 선택 (forward, backward, stepwise)
# forward
fit.null <-lm(가격~1, data=temp) # 독립변수가 없는 형태 
fit.forward<-step(fit.null, scope = list(lower=fit.null, upper = fit), direction = 'forward')
summary(fit.forward)

# backward
fit.backward <-step(fit, scope = list(lower=fit.null, upper = fit), direction = 'backward')
summary(fit.backward)

# stepwise
fit.both <- step(fit.null, scope=list(lower=fit.null, upper=fit),
                 direction="both")
summary(fit.both)

#forward 결과로 선택된 변수 
fit <- lm(가격 ~ 마력 + 회사명 + 종류 + 배기량 + 하이브리드 + 
              중량 + 변속기 + 년식 + 연비 + 디젤 + 토크, data = temp)

# 회귀진단
#다중공선성: 독립변수들간의 상관성이 높음 

install.packages("car")
library(car)

pairs(temp[names(temp)])#변수 선택전 
pairs.panels(temp[names(temp)])

vif(fit) #다중공선성 체크 

fit1<- lm(가격 ~ 마력 + 회사명 + 종류 + 배기량 + 하이브리드 + 
              중량 + 변속기 + 년식 + 연비 + 디젤 , data = temp)
vif(fit1)

fit2<- lm(가격 ~ 마력 + 회사명 + 종류 + 배기량 + 하이브리드 + 변속기 + 년식 + 연비 + 디젤 , data = temp)
vif(fit2)

fit3<-lm(가격 ~ 마력 + 회사명 + 종류 + 하이브리드 + 변속기 + 년식 + 연비 + 디젤 , data = temp)
vif(fit3)

#다중공선성이 의심되는 변수 제거 
summary(fit3)

# 이상치 제거
par(mfrow = c(2,2))
plot(fit3)
#정규성, 독립성, 선형성, 등분산성 확인

fit<-lm(가격 ~ 마력 + 회사명 + 종류 + 하이브리드 + 변속기 + 년식 + 연비 + 디젤 , data = temp[-c(3,4,10),])
summary(fit)

plot(fit)

#회귀모형으로 가격 예측

pre <-predict(fit, newdata = temp) #회귀모형 평가  
head(pre) 

#점이 아닌 하한과 상한이 존재하는 예측구간
pre <-predict(fit, newdata = temp, interval = 'predict')
pre <-as.data.frame(pre)
head(pre)


pre<-cbind(pre, temp$가격)
head(pre)

tf<-NA
pre<-cbind(pre, tf)
pre$tf[pre$`temp$가격`>= pre$lwr & pre$`temp$가격` <= pre$upr] <- T
pre$tf[is.na(pre$tf)] <- F
#예측구간안에 실제 값이 포함되면 t, 아니면 f

head(pre)
sum(pre$tf=='TRUE')/dim(pre)[1]
#예측률 
