#####7주차######
#####사회 연결망 분석(SNA)#####
if(!require(tidygraph)){install.package(tidygraph);library(tidygraph)}
#네트워크 분석하는 패키지
if(!require(ggraph)){install.package(ggraph);library(ggraph)}
#관계형 데이터의 그래픽 문법 패키지

feat<-read.csv('featuring.csv')
class(feat)

#데이터프레임을 그래프 형식으로 바꾸기
fg <- as_tbl_graph(feat) #tibble : 데이터프레임의 업그레이드 버전

class(fg)
plot(fg)

ggraph(fg) + geom_node_point()+geom_edge_link()
#node: 가수 #edge: 관계 
#layout 종류가 많음 
ggraph(fg, layout = 'nicely')+ geom_node_point()+geom_edge_link()

#지금부터 kk layout 사용
feat %>% as_tbl_graph() %>% ggraph(layout='kk')+ geom_node_text(aes(label=name))+geom_edge_link(aes(start_cap = label_rect(node1.name), end_cap = label_rect(node2.name)))
#geom_edge_link는 노드에서 어느정도 떨어진 후 선을 나타내기 
#어떤 노드가 중요한지 모르겠다.

#중심성 : 노드의 상대적 중요성을 나타내는 척도 
#centrality_중심성종류() : 중심성 betweenness을 사용
#betweenness(매개중심성)  : 노드사이의 최단 경로를 계산 
#연결한다고 할때 유독 특정한 노드를 거쳐야 할 일이 만다면 , 이 노드가 중요하다고 보는 것. 
library(dplyr)
feat %>% as_tbl_graph() %>% mutate(bet=centrality_betweenness()) %>% as_tibble %>% arrange(desc(bet))

######지하철########
subway <-read.csv('subway.csv')
head(subway)
subway %>% as_tbl_graph() %>% ggraph(layout='kk') + geom_edge_link(aes(color=line)) + geom_node_point(color='gray25', size=1)
#호선마다 색 다르게 표현 

#고유벡터 중심성 : eg = centrality_eigen()
#고유벡터 중심성 : 다른 노드의 중심성 반영 
subway %>% as_tbl_graph() %>% mutate(eg=centrality_eigen()) %>% as_tibble %>% arrange(desc(eg))
#중심성을 계산할 때 모든 노드가 중요하다고 생각 

#승하차 인원 정보를 활용 
metro <-read.csv('metro.csv')
head(metro)

#고유벡터 중심성 
metro %>% as_tbl_graph() %>% mutate(eg=centrality_eigen()) %>% as_tibble %>% arrange(desc(eg))
#역과 역을 1대1로 연결, 가중치 부여 하기 전

#pagerank중심성
#각 노드의 영향력을 다른 노드로 전파할 때, 외부로 향하는 모든 간선의 수(weighted 그래프일 경우 weighted의 합 )으로 나누어 out-edge로 영향력이 지나치게 퍼지는 것을 막아줌. 
metro %>% as_tbl_graph() %>% mutate(eig=centrality_pagerank(weights=total)) %>% as_tibble %>% arrange(desc(eig))

#school
school <- data.frame(사람=c('가', '나', '다', '라', '마', '바'), 
                       고교=c('1', '2', '3', '1', '2', '3'), 
                       대학=c('a', 'b', 'a', 'b', 'a', 'b'))

school %>% as_tbl_graph() %>% ggraph(layout='kk') + 
  geom_edge_link(aes(start_cap = label_rect(node1.name), 
                     end_cap = label_rect(node2.name))) + 
  geom_node_text(aes(label=name))
#같은 고교 출신만 연결

school_high <-school[,c(1,2)]
school_univ <-school[,c(1,3)]
rbind(school_high, school_univ) #열 이름이 다르기 때문에 연결 안됨.

names(school_high)[2] <-'학교'
names(school_univ)[2]<-'학교'
school<- rbind(school_high, school_univ) #열 이름을 동일하게 변경해서 
school %>% as_tbl_graph() %>% ggraph(layout='kk') + 
  geom_edge_link(aes(start_cap = label_rect(node1.name), 
                     end_cap = label_rect(node2.name))) + 
  geom_node_text(aes(label=name))
#대학까지 연결한 그래프 
#:이분 그래프 '서로 다른 그룹에 있는 노드와 연결되어 있음.' 

if(!require('igraph')){install.packages('igraph');library(igraph)}
class(school)
sg<-graph_from_data_frame(school)
sg

#이분 그래프 안에서 노드가 어떤 특징을 가지는지 알려주는 함수 
bipartite_mapping(sg)
V(sg)
V(sg)$type <-bipartite_mapping(sg)$type
as_incidence_matrix(sg)#행렬생성
sm<- as_incidence_matrix(sg)%*%t(as_incidence_matrix(sg))

#대각원소의 값을 0으로 
diag(sm)=0

sm %>% as_tbl_graph() %>% ggraph(layout='kk') + 
  geom_edge_link(aes(start_cap = label_rect(node1.name), 
                     end_cap = label_rect(node2.name))) + 
  geom_node_text(aes(label=name))

####단계구분도#####
if(!require(ggiraphExtra)){install.packages('ggiraphExtra');library(ggiraphExtra)}
if(!require(tibble)){install.packages('tibble');library(tibble)}

head(USArrests)

#주에 변수명 설정
crime <-rownames_to_column(USArrests, var = 'state')

#지역별 차이를 색깔별로 나타내기

library(maps) #세계지도 데이터베이스
if(!require(mapproj)){install.packages('mapproj');library(mapproj)}
#위도와 경도 표시
library(ggplot2)

states_map <-map_data('state')
head(states_map)
ggChoropleth(data=crime, aes(fill=Murder, map_id = state), map = states_map)
