library(readxl)
library(ggplot2)

# importando data de plantila de mercado
plantillames<-read_xlsx("C:/Users/LBarrios/Documents/Plantilla mercado MAT Mar-21.xlsx",
                           range = "A3:G374" ,
                           sheet= "MES")

plantillaytd<-read_xlsx("C:/Users/LBarrios/Documents/Plantilla mercado MAT Mar-21.xlsx",
                        range = "A3:G375" ,
                        sheet= "YTD")

plantillamat<-read_xlsx("C:/Users/LBarrios/Documents/Plantilla mercado MAT Mar-21.xlsx",
                        range = "A3:M374" ,
                        sheet= "MAT")

# cambiar nombre de variables
colnames() # VER NOMBRES DE VARIABLES
colnames(plantillames)[2]<-"CADENAUNID"
colnames(plantillames)[3]<-"INDEPENDUNAUNID"
colnames(plantillames)[5]<-"CADENASOLES"
colnames(plantillames)[2]<-"INDEPENDSOLES"

colnames(plantillaytd)[2]<-"CADENAUNID"
colnames(plantillaytd)[3]<-"INDEPENDUNAUNID"
colnames(plantillaytd)[5]<-"CADENASOLES"
colnames(plantillaytd)[2]<-"INDEPENDSOLES"


####################################
# PLANTILLA MERCADO PREM_OCUV_LANZ #
####################################


#importar por producto
for (i in c("ANESTEARS","REFRESKAN-T PLUS-ASTEROSS","ATROPINA",
            "BIOTEARS G GEL-VISTAGEL","BIOTEARS SOL","BRINZOLAN-T",
            "CLACIER","COSOMIDOL-GLAMAX","FENILEFRINA",
            "XALOPTIC-HOPRIX-XENDA","HYALO COMFORT","LAMOFLOX",
            "LANCIPROX-DX","MACUVIT","MEGATOB","PATADINE PLUS-MELIUS",
            "SYSTALAN-SYSTALAN OCV","TROPICAMIDA","TRUSOMIDA","XALOPTIC-T")) {
  
jpeg(filename =paste0("boxplot",i,".jpeg")) #comando para iniciar a grabar una imagen

i<-read_xlsx("C:/Users/LBarrios/Documents/PREM_OCUV_LANZ.xlsx",
                        range = "B8:AD21",
                        sheet= i )
#dando nombres a columnas
colnames(i)<-c("PRODUCTO","LAB","FECHA","PRES",
"VALOR_PROM_IMS","VALOR_U./CTA_PROM._IMS","NA","MES_UNID","MES_TOTAL_UN_CTA",
"MES_PART_%_UNID","MES_VAL_SOLES","MES_PART_%_SOLES","YTD_UNID","YTD_TOTAL_UN_CTA",
"YTD_PART%_UNID","YTD_VAL_SOLES","YTD_PART%_SOLES","MATANTERIOR_UNID",
"MATANTERIOR_TOTAL_UN_CTA","MATANTERIOR_PART%_UND","MATANTERIOR_VAL_SOLES",
"MATANTERIOR_PART%_SOLES","MATACTUAL_UND","MATACTUAL_TOTAL_UN_CTA","MAT_PART%_UNID",
"MATCRECIANUAL_UNID","MATACTUAL_VAL_SOLES","MATACTUAL_PART%_SOLES","MATCRECIANUAL_SOLES")

ggplot(data = i )+geom_boxplot(mapping = aes(x=MES_UNID))

dev.off() #comando para terminar la grabación de la imagen


}

jpeg(filename =paste0("boxplot","ANESTEARS",".jpeg"))
ANESTEARS<-read_xlsx("C:/Users/LBarrios/Documents/PREM_OCUV_LANZ.xlsx",
             range = "B8:AD21",
             sheet= "ANESTEARS" )

colnames(ANESTEARS)<-c("PRODUCTO","LAB","FECHA","PRES",
               "VALOR_PROM_IMS","VALOR_U./CTA_PROM._IMS","NA","MES_UNID","MES_TOTAL_UN_CTA",
               "MES_PART_%_UNID","MES_VAL_SOLES","MES_PART_%_SOLES","YTD_UNID","YTD_TOTAL_UN_CTA",
               "YTD_PART%_UNID","YTD_VAL_SOLES","YTD_PART%_SOLES","MATANTERIOR_UNID",
               "MATANTERIOR_TOTAL_UN_CTA","MATANTERIOR_PART%_UND","MATANTERIOR_VAL_SOLES",
               "MATANTERIOR_PART%_SOLES","MATACTUAL_UND","MATACTUAL_TOTAL_UN_CTA","MAT_PART%_UNID",
               "MATCRECIANUAL_UNID","MATACTUAL_VAL_SOLES","MATACTUAL_PART%_SOLES","MATCRECIANUAL_SOLES")

ggplot(data = "ANESTEARS" )+geom_boxplot(mapping = aes(x=MES_UNID))

dev.off() #comando para terminar la grabación de la imagen




