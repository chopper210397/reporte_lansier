library(writexl)
library(RODBC)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(fpp2)
library(readxl)
# 
# install.packages("archive")
# install.packages("DataExplorer")
# install.packages("fpp2")
sqlcomercial<-odbcConnect("SQLuis",uid = "sa",pwd = "Comercial.2020")

data<-sqlQuery(sqlcomercial,"select * from Venta_Lansier")

data2<-data %>% select(fuente,periodo,cant,subtotal,dpto,distrito,provincia,tipoart,colorequi)
data3<-as.data.frame( trimws(data2$periodo,"b"))
data3$subtotal<-trimws(data2$subtotal,"b")
colnames(data3)<-c("periodo","subtotal")
data3$subtotal<-as.numeric(data3$subtotal)
# convertimos los NA en 0 para poder trabajar mejor sino sale error en las sumas
data3[is.na(data3)] <- 0
# creamos la data agrupada por periodos
data3<-data3 %>% group_by(periodo) %>% summarise(subtotal=sum(subtotal))
data4<-data3[-24,]
data4<-data4[-1,]
# poniendo en formato time series
data5<-data4 %>% select(subtotal)
data5<-data5 %>% mutate(subtotal=subtotal/1000)
data5<-ts(data5,start = c(2020,1),end = c(2021,12),frequency = 12)
#----------------------------------------------------------------------------------#
# ANALISIS PRELIMINAR
#----------------------------------------------------------------------------------#
# ANALIZANDO TENDENCIA COMO TOTAL DE VENTA LANSIER MES A MES POR AÑO
autoplot(data5)+labs(x="",y="Ventas en miles",title = "Ventas totales Lansier")
ggseasonplot(data5)+labs(x="",y="Ventas en miles",title = "Ventas por año")
ggsubseriesplot(data5)
# del grafico me generan grandes dudas, que produtos hicieron que suba tanto entre mayo a agosto
# del 2020 y de nuevo en diciembre de 2020, y por que ha bajado tanto en diciembre de 2021
data$artdesValid<-trimws(data$artdesValid,"b")
mayo<-data %>% filter(periodo=="2020-05-01") %>% group_by(artdesValid) %>% arrange(-subtotal)
# ggsave("a.png",dpi = 300)
distintosmayo2020<-distinct(data %>% filter(periodo=="2020-05-01") %>% select(artdesValid))

#-------------------------------------------------------------------------------
# ANALIZANDO TENDENCIA POR CATEGORIZACIÓN (incluyendo productos covid)
#-----------------------------------------------------------------------------
data$artdesValid<-trimws(data$artdesValid)
data$subtotal[is.na(data$subtotal)] <- 0
data$cant[is.na(data$cant)]<-0
# con esto ya tengo agrupado por categoria y por periodo
data<-data %>% filter(fuente!="KUSHKA")
data<-data %>% filter(categorizacion!="")
badperiod<-which(data$periodo=="2021-10-09")
data[badperiod,2]<-"2021-10-01"
categorbyyear<-data %>% group_by(periodo,categorizacion) %>% summarise(subtotal=sum(subtotal))
# graficando
# para una sola categorización
categorbyyear %>%
  filter(categorizacion=="MASIVO") %>%
  ggplot(mapping = aes(x=periodo,y=subtotal))+geom_line()
# para todas las categorizaciones
categorbyyear %>% mutate(subtotal=subtotal/1000) %>% 
  ggplot(mapping = aes(x=periodo,y=subtotal,color=categorizacion))+geom_line()

# ANALIZANDO SIN DATA COVID
datanocovid<-data %>% filter(categorizacion!="COVID")
categorbyyearnocovid<-datanocovid %>% group_by(periodo,categorizacion) %>% summarise(subtotal=sum(subtotal))
# graficando
categorbyyearnocovid %>% mutate(subtotal=subtotal/1000) %>% 
  ggplot(mapping = aes(x=periodo,y=subtotal,color=categorizacion))+geom_line()

#-----------------------------------------------------------------------------------------#
#             DESAGREGANDO POR CATEGORÍA, ANALISIS CATEGORIA POR CATEGORIA                #
#-----------------------------------------------------------------------------------------#
datanocovid$artdesValid<-toupper(datanocovid$artdesValid)
datanocovid$periodo<-as.Date.character(datanocovid$periodo,format = "%Y-%m-%d")

desagregando<-datanocovid %>%
  group_by(artdesValid) %>%
  summarise(subtotal=sum(subtotal)) %>%
  arrange(-subtotal)


# graficos total desdel el 2020 de producto por encima de la media de ventas y por debajo ordenados de mayor a menor
mediabyartdes<-mean(desagregando$subtotal)
desagregando %>% filter(subtotal>mediabyartdes) %>%
  ggplot(aes(x = reorder(artdesValid,subtotal), y = subtotal/1000000)) +
  geom_bar(stat="identity", color='skyblue',fill='steelblue')+coord_flip()

desagregando %>% filter(subtotal<mediabyartdes & subtotal>0) %>%
  ggplot(aes(x = reorder(artdesValid,subtotal), y = subtotal/1000)) +
  geom_bar(stat="identity", color='skyblue',fill='steelblue')+coord_flip()

#-----------------------------------------------------------------------------------------#
#                                 DESAGREGANDO POR PRODUCTO                               #
#-----------------------------------------------------------------------------------------#
# productos que en el 2021 estan por encima de la media total en subtotal
top12artdes<-datanocovid %>% filter(periodo>"2020-12-01") %>% group_by(artdesValid) %>%
  summarise(subtotal=sum(subtotal)) %>% filter(subtotal>mediabyartdes) %>% arrange(-subtotal) %>% select(artdesValid)
top5artdes<-top12artdes[1:5,1]
dataframidex<-datanocovid %>% filter(artdesValid=="FRAMIDEX NF SOL OFT EST X 2,5ML" & periodo>"2021-01-01")
dataframidex %>% group_by(periodo) %>% summarise(subtotal=sum(subtotal)) %>%
  arrange(periodo) %>% ggplot(aes(x=periodo,y=subtotal/1000))+geom_line()

periodandartdesvalid<-datanocovid %>%
  group_by(artdesValid,periodo) %>% summarise(subtotal=sum(subtotal))

periodandartdesvalid %>% filter(periodo>"2020-12-01" , artdesValid %in% top5artdes$artdesValid ) %>%
  ggplot(aes(x=periodo,y=subtotal/1000, group=artdesValid))+
  geom_line(aes(color=artdesValid))+geom_point()+ theme(legend.position="bottom")

ggsave("top5.png",dpi = 300)
                                                                                   