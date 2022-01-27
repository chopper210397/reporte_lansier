library(dplyr)
library(ggplot2)
library(readr)
library(stringr)
datapeea<-read.csv("C:\\Users\\LBarrios\\Downloads\\data_peea_macroeconometria2 - Mensuales.csv")
datapeea<-datapeea[-1,]
names(datapeea)<-c("fecha","creditconsum","pbi")
# GRAFICOS DE BARRAS
#seleccionando solo los eneros en fecha para creditconsum
datapeea %>% filter(str_detect(fecha,"Ene")) %>% 
  mutate(creditconsum=as.numeric(gsub(",",".", creditconsum))) %>% 
  ggplot(mapping = aes(x=reorder(fecha,fecha),y=creditconsum))+
  geom_col()+theme(axis.text.x = element_text(angle=45,hjust=1))

#seleccionando solo los eneros en fecha para pbi
datapeea %>% filter(str_detect(fecha,"Ene")) %>% 
  mutate(pbi=as.numeric(gsub(",",".", pbi))) %>% 
  ggplot(mapping = aes(x=reorder(fecha,fecha),y=pbi))+
  geom_col()+theme(axis.text.x = element_text(angle=45,hjust=1))
# GRAFICOS DE LINEAS

 datapeea %>% filter(str_detect(fecha, "Dic" )) %>% 
  mutate(pbi=as.numeric(gsub(",",".", pbi))) %>% 
  ggplot(mapping = aes(x=reorder(fecha,fecha),y=pbi))+
  geom_point(color="blue")+theme(axis.text.x = element_text(angle=65,hjust=1))+xlab("")+ylab("PBI")
 
 # "Ene01" "Feb01" "Mar01" "Abr01" "May01" "Jun01" "Jul01" "Ago01" "Sep01" "Oct01" "Nov01" "Dic01
