#este es el maildefinitivoR
library(mailR)
library(rJava)
library(dplyr)
library(readxl)
library(tidyr)
library(lubridate)
#aqui debo cambiar el nombre de la data al nombre del excel con el que trabajaré, además, debe estar en la carpeta
#mis documentos para que pueda leerlo

PASS<- as.character("chopper210397")

data<-read_xlsx("C:/Users/User/Documents/datapresentacion.xlsx")

dia <-day( Sys.Date())
mes<-if(month(Sys.Date()) == 10){"Octubre"}
for(i in 1:nrow(data)){
  equipo = data$Equipo[i]
  zona = data$Zona[i]
  correo = data$Correo[i]
  nombre  = data$Nombre[i]
  total = (data$Total[i])*100
  premium = (data$Premium[i])*100
  lanzamiento = (data$Lanzamiento[i])*100
  ocuvial = (data$Ocuvial[i])*100
  normal = (data$Normal[i])*100
  masivo = (data$Masivo[i])*100
  
  htmlmsg ="<p>&nbsp;</p>
    <table style='text-align: center; width: 340px; '>
    <tbody>
    <tr style='height: 61px;'>
    <td style='width: 301.984px; height: 61px;'>
    <p style='text-align: left;'>Hola "
  htmlmsg = paste0(htmlmsg,nombre,",</p>
    <p style='text-align: left;'>Tu cumplimiento al ",dia," de ",mes," :</p>
    </td>
    <td style='width: 131.016px; height: 61px;' scope='colgroup'>&nbsp;&nbsp;
  <table style='height: 90px; width: 90px; background-color: dodgerblue;-webkit-border-radius: 50%
; -moz-border-radius: 50%;border-radius: 50%; border-collapse: collapse;' border='0.005'>
    <tbody>
    <tr style='height: 54px;'>
    <td style='width: 100%; height: 54px; text-align: center; color: white;font-size:2em'>",total)
  htmlmsg = paste0(htmlmsg,"% </td>
    </tr>
    </tbody>
    </table>
    </td>
    </tr>
    </tbody>
    </table>
    <p>&nbsp;</p>
    <table style='height: 42px; width: 50%; border-collapse: collapse; border-style: hidden;' border='0.05'>
    <tbody>
    <tr style='height: 21px;'>
    <td style='width: 5%; height: 21px; text-align: center;'>Premium</td>
    <td style='width: 5%; height: 21px; text-align: center;'>Lanzamiento</td>
    <td style='width: 5%; height: 21px; text-align: center;'>Ocuvial</td>
    <td style='width: 5%; height: 21px; text-align: center;'>Normal</td>
    <td style='width: 5%; height: 21px; text-align: center;'>Masivo</td>
    </tr>
    <tr style='height: 21px;'>
    <td style='width: 5%; height: 21px; font-size: 2em; padding:0px 10px; font-weight: bold; text-align: center;'>")
  htmlmsg = paste0(htmlmsg,premium,"% </td>
    <td style='width: 5%; height: 21px; font-size: 2em; padding:0px 10px; font-weight: bold; text-align: center;'>")
  htmlmsg = paste0(htmlmsg,lanzamiento,"% </td>
    <td style='width: 5%; height: 21px; font-size: 2em; padding:0px 10px; font-weight: bold; text-align: center;'>")
  htmlmsg = paste0(htmlmsg,ocuvial,"% </td>
    <td style='width: 5%; height: 21px; font-size: 2em; padding:0px 10px; font-weight: bold; text-align: center;'>")
  htmlmsg = paste0(htmlmsg,normal,"% </td>
    <td style='width: 5%; height: 21px; ;font-size: 2em; padding:0px 10px; font-weight: bold;text-align: center;'>")
  
  htmlmsg = paste0(htmlmsg,masivo,"% </td> 
                   </tr> 
                   
                   </tbody> 
                   
                   </table>")
  
  
  
  
  send.mail(from = "luisbarrios2197@gmail.com",
            to = correo,
            subject = paste0("Cumplimiento de venta por zona: ",zona),
            body = htmlmsg,
            html = TRUE,
            smtp = list(host.name="smtp.gmail.com",
                        port=465,
                        user.name="luisbarrios2197",
                        passwd=PASS,
                        ssl=TRUE),
            authenticate = TRUE,
            send = TRUE)
  
  
}