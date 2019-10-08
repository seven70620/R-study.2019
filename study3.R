#2019. 10. 08

####필터링####

z <- c(5,2,-3,8)
w<- z[z*z>8]
w

z*z>8
z[c(T,F,T,T)]

z[z>3] <-0
z

#is.na() 
x<-c(6, 1:2, NA, 12)
x
is.na(x)

#which()
which(x>5) 
y<-which(x>5)
length(y) 

#%in% 
x<-c(3,1,4,1)
x %in% c(2,1,4)

#match()
x<-c(3,1,12)
match(x, c(2,1,4))

####CASTING#####

a=0L 
typeof(a)
a[2] <- 1
a
typeof(a)

m<-matrix(1:10, 5,2)
m
b = m[,-1]
b[5,1]
b = m[,-1, drop=F]
class(b)

#matrix -> vector: c()
a = matrix(1:10,5,2)
a
b = c(a)
b

#vector -> factor : as.factor()
a = c('tom', 'jin','jun')
b = as.factor(a)
b

c(b)

#list, data.frame ->vector : unlist()
a=list()
for (i in 1:5) a[[i]] <-i  #list, dataframe 인덱스 
a
b<-unlist(a)
b

c=data.frame('age' = c(17,18,19), 'home' = c('seoul', 'busan', 'jeju'))
class(c$home) #factor
c ###''
d = unlist(c)
d
class(d)

#vector -> matrix : as.matrix()
a = 1:100
b = as.matrix(a, ncol=2) # as.matrix사용해서 2열 이상 행렬 만드는 방법 
b

#matrix -> data.frame : as.data.frame()
a = matrix(1:10, 5,2)
a
b = as.data.frame(a)
b
class(b)

#data.frame -> list : unclass()
names(b) = c('a','b') #colnames()도 가능 
b
c = unclass(b)
c
class(c)

a = c('1','2','3')
as.double(a)
#as.character()
#as.numeric() = as.double()

#######반복문#######

#for문

for(i in 1:9)
{
  result = i*2
  print(result)
}

#while문
i=1
while(i<10)
{
  result = i*2
  print(result)
  i = i+ 1
}

#repeat문

i=1
repeat{
  result = 2*i
  print(result)
  if(i>=9) break
  i = i+1
}

#next
for(i in 1:4)
{
  print(i)
  print('cmd1')
  print('cmd2') 
  if(i==3){
    next
  }
  print('cmd3')
}

#break
for(i in 1:4)
{
  print(i)
  print('cmd1')
  print('cmd2') 
  if(i==3){
    break
  }
  print('cmd3')
}

####for 문제#####
head(iris)


