# 20191105
rm(list=ls())
# << R부리영감 스터디 5주차  >> 

# 기본 세팅 
rm(list=ls())
setwd('C:/Users/서용비/Documents/카카오톡 받은 파일')
getwd()

# 데이터 불러오기 & 확인 -----------------
DF = read.csv('example_studentlist.csv')
head(DF,n=8)
str(DF)
# 1.  plot()  ----------------------------
#  :: level별 그래프 보기
plot(DF$age)
plot(DF$height, DF$weight) #x축, y축 
plot(DF$height ~ DF$weight) #정규표현식의 한 종류로 종속변수 ~ 설명변수 
plot(DF$height,DF$sex) #sex는 명목형 변수 
plot(DF$sex, DF$height) #boxplot이 나옴. 명목형 변수를 독립변수로 하는 것이 정보가 더 많음. 

DF2 = data.frame(DF$height, DF$weight, DF$age)
plot(DF2) #PLOT함수는 2차원 그래프 
plot(DF) 
#PLOT은 명목형, 수치형 데이터 사용, 이 두 경우가 아니면 as.factor를 이용해 명목형 변수로 변경하는 것이 좋음. 
# Q. 몸무게와 키의 산포도 그래프를 나타내면서 *점의 종류*는 남자와 여자를 별도로 표시

plot(DF$weight, DF$height, pch = as.numeric(DF$sex))##pch :점의 종류는 성별 
legend('topright',c('남', '여'),pch = DF$sex)

#############
#조건화 그래프 coplot
coplot(DF$weight~DF$height|DF$sex) #|는 정규표현식이므로 ~사용하기 
plot(DF$weight~DF$height, ann = F) # ann옵션은 어떠한 라벨도 출력X
title(main = "키-몸무게 상관관계")
title(xlab="키", ylab="몸무게")
grid()
abline(v = mean(DF$height), col="lightblue")  #세로
abline(h = mean(DF$weight), col="lightpink")  #가로

# 2. barplot ---------------------------------------------------------------------------

#Q. 혈액행별로 몇 명 있는지?
freq_blood = table(DF$bloodtype)
freq_blood
# Q. 제목: 혈액형별 빈도수 ,y축: 빈도수, x축: 혈액형
barplot(freq_blood)
title(xlab = '혈액형', ylab = '혈액형별 빈도수', main = '혈액형별 빈도수')

#tapply(벡터, 레벨, 적용함수)
#명목형 변수의 레벨별로 함수를 적용해서 값을 구해줌.
height_1 = tapply(DF$height, DF$bloodtype, mean)
barplot(height_1, ylim = c(0,200))

# 3. boxplot ---------------------------------------------------------------------------
boxplot(DF$height) 

#Q. 레벨별로 구분하려면? :blood type별로 키 구하기 by using plot()

# Q. boxplot() ftn 으로 나타내기
boxplot(DF$height~DF$bloodtype) 
plot(DF$bloodtype, DF$height)

# 그래프 해석?
# : 1. B형의 키의 분산이 큰 편 
# : 2. AB형의 평균키가 큰 편 


################################################################################################

#. ggplot2, ggthemes
if(!require(ggplot2)){install.packages('ggplot2');library(ggplot2)}
if(!require(ggthemes)){install.packages("ggthemes");library(ggthemes)}

# 예시 - 이해할 필요 X ----------------------------------------------
#한번에 표현
ggplot(data = diamonds, aes(x=carat, y=price, colour=clarity)) +
  geom_point() +theme_wsj
 
# 따로따로
g1 = ggplot(data = diamonds, aes(x=carat, y=price, colour=clarity))
g2 = geom_point()
g3 = theme_wsj()

g1 + g2 + theme_bw()

# 1. aes :: 미적 요소 매핑 (aesthetic mapping)

g1 = ggplot(DF, aes(x =height, y=weight, colour=bloodtype))
g1 + geom_point()
g1 + geom_line() 
#g1에서 사용했던 객체 값을 그대로 사용하기 때문에 뒤에서는 언급할 필요 없음. 
#geom_point와 line은 g1의 객체를 그대로 받아서 그래프를 그림

g1 + geom_point() + geom_line()
g1 + geom_point(size = 10) + geom_line(size = 1)

#aes는 다시 정의할 수 있음, 추가 가능 
g1 + geom_point(size = 10) + geom_line(aes(colour=sex), size = 1) #legend에 성별이 추가됨


# 3. facet_grid() ---------------------
# :: 명목형 변수를 기준으로 나눠서 별도의 그래프를 그려 줌

g1 + geom_point(size = 10) + geom_line(size = 1) + facet_grid(.~sex) #sex별 y축 범위가 동일 
g1 + geom_point(size = 10) + geom_line(size = 1) + facet_grid(sex~.)#sex별 x축 범위가 동일 
g1 + geom_point(size = 10) + geom_line(size = 1) + facet_grid(sex~., scales="free") #각각의 스케일에 맞게 범위를 조정 
g1 + geom_point(size = 10) + geom_line(size = 1) + facet_grid(.~sex, scales="free") # y축 범위가 동일 해야 하므로 적용 안됨.
g1 + geom_point(size = 10) + geom_line(size = 1) + facet_wrap(~sex, scales="free") #y축범위를 따로 지정해줌 

#둘의 차이 ?
# facet.grid는 x축의 범위를 동일하게 할때(sex~.) y축 범위 scale을 조정 
# facet.wrap은 y축 범위를 각각 따로 지정 (~sex)

# 4. geom_bar()  -----------------------------------

ggplot(DF, aes(x=bloodtype)) + geom_bar()
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar()
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar(position="dodge") #SEX별로 따로 
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar(position="dodge", width=0.5)  #그래프 넓이 조정 가능
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar(position="identity") #빨강과 파랑 겹쳐져서 
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar(position="fill")  #누적 그래프 원할 때, 전체를 채우는 바 그래프!, 도수가 아니라 비율 


# 5. geom_histogram  -------------------------------

#geom_histogram() 안에 계급을 알려 주면 그래프를 바로 그려 줌
g1 = ggplot(diamonds, aes(x=carat))
g1 + geom_histogram(binwidth=0.1, fill="orange") #y축은 자동으로 도수, 

g1 + geom_histogram(aes(y=..count..), binwidth=0.1, fill="orange") 
#..count.. :예약어, for 데이터프레임과의 혼용 막음

g1 + geom_histogram(aes(y=..ncount..), binwidth=0.1, fill="orange") #표준화된 도수값
g1 + geom_histogram(aes(y=..density..), binwidth=0.1, fill="orange") #밀도값으로 show
g1 + geom_histogram(aes(y=..ndensity..), binwidth=0.1, fill="orange") #표준화된 밀도값으로 show

# +) hist(): breaks 안에 개수를 넣음, but geom_hist는 계급의 단위 넣는 차이!

#Q. facet_grid()로 명목형 변수별로 따로따로 그래프를 그리려면?
# Q. color 변수의 level별로 그리기 명령 
g1 + geom_histogram(binwidth=0.1, fill="orange") + facet_grid(color~.) #x축이 동일, y축도 동일 간격-> 맨아래쪽은 빈공간이 많음. 
g1 + geom_histogram(binwidth=0.1, fill="orange") + facet_grid(color~., scale="free") #scale이 맞게 조정 

#level별로 겹쳐서 보려면?
g1 + geom_histogram(binwidth=0.1, aes(fill=color), alpha=0.5) #alpha는 투명도를 의미함함

# ->> ggplot2에서는 hist()보다는 다양한 방법으로 히스토그램이 표현됨
# so, 서로 비교를 요하는 명목병 변수가 있을 때는 geom_hist 이용해서 그리는 게 더 빠르고 정확! 


# 6. geom_point (산점도)  -------------------------------

# :: 기본 사용법
DF
g1 = ggplot(DF, aes(x=weight, y=height))
g1 + geom_point()

# Q. 명목형 변수의 레벨별로 컬러를 다르게 나타내려면? 레벨:성별(sex)
g1 + geom_point(aes(color = sex))

# Q. 성별(sex) 별로 색을 다르게 하고, 각 성별에서는 혈액형(bloodtype)별로 점모양 다르게 하려면?
g1 + geom_point(aes(color=sex, shape=bloodtype), size=7) #점 모양 바꾸기

# Q. color에 연속형 변수넣기 가능? (O)
g1 + geom_point(aes(color=height, shape=sex), size=7) #색의 진하기로 구분 

# Q. size에  연속형 변수 넣기?
g1 + geom_point(aes(size=height, shape=sex), color="orange") #size 인자에 연속형 변수가 반영

# +) alpha값으로 그래프 꾸미기
g1 + geom_point(aes(color=sex, shape=bloodtype), size=7, alpha=0.6)

# +) 회귀분석 - 두 변수의 관계를 함수식으로 나타내기
g1 + geom_point(aes(color=sex), size=7) + geom_smooth(method="lm", color="grey35")

# +) 자료가 몇 개 없는 경우, 점마다 이름을 넣을 수 있음
g1 + geom_point(aes(color=sex), size=7) + geom_text(aes(label=DF$name))

# Q. 점과 라벨이 겹치지 않게 하려면? : 위치 조정 need by vjust()
g1 + geom_point(aes(color=sex), size=3) + geom_text(aes(label=DF$name), vjust=-1.1, color="grey35")

###########################################################################################
# ++)

g1 + geom_point(aes(color=sex), size=3) + geom_text(aes(label=DF$name), vjust=-1.1, color="grey35") + theme_economist()
