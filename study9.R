#####R study 9주차####
##interactive 그래프##
require(plotly)
if(!require(plotly)){install.packages('plotly');library(plotly)}
require(ggplot2)
# 마우스 움직임에 반응해서 실시간으로 반응하는 그래프

data(mpg)
head(mpg)
p<-ggplot(data = mpg, aes(x=displ, y=hwy, col = drv))+geom_point()
p
ggplotly(p) #점에 커서를 올리면 3가지 정보가 나타남. 

#ggplot 
data(diamonds)
d<-ggplot(data = diamonds, aes(x =cut, fill=clarity))+geom_bar()
d
#y값을 자동으로 설정
ggplotly(d)

# interactive 시계열 그래프 
if(!require(dygraphs)){install.packages("dygraphs"):library(dygraphs)}
economics = ggplot2::economics #ggplot2 패키지 안에 있는 economics 데이터를 가져옴 

head(economics)

#데이터가 시계열 데이터라는 것을 r에 알려줘야 함.
library(xts)
#시간에 따른 실업자 수를 알고 싶다. 
eco = xts(economics$unemploy, order.by = economics$date)
dygraph(eco)

#날짜를 지정하고 싶다
dygraph(eco) %>% dyRangeSelector()

#실업자수와 저축률간의 관계
eco_p <-xts(economics$psavert, order.by = economics$date)
eco_u <-eco

c_eco = cbind(eco_u, eco_p) 
dygraph((c_eco)) #두 변수의 범위가 다르기 때문에 나타난 현상 

eco_u<-xts(economics$unemploy/1000, order.by = economics$date)
c_eco = cbind(eco_u, eco_p)
dygraph((c_eco))

head(c_eco)

#diamonds 그래프

p<-ggplot(data = diamonds, aes(x=cut, fill = clarity)) + geom_bar(position='dodge')
p #막대를 개별적으로 표현
ggplotly(p)

######
plot_ly(z=volcano, type="surface")

#facet_grid: 옆으로 흔들기 facet_wrap: 범위 맞추기
data(iris)
p = plot_ly(data=iris, x=Petal.Length, y=Petal.Width,
            color = Sepal.Length, colors=c("#132B43", "#56B1F7"),
            mode="markers")

test = ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width,
                             color = Species)) + geom_point() + facet_wrap(~Species)
test
plotlyTest = ggplotly(test)
plotlyTest

####

