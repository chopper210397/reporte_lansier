library(ggplot2)
library(mailR)
library(rJava)
library(dplyr)
library(devtools)
install.packages("mailR", dep = T)

library(mailR)
install_github("rpremraj/mailR")

install.packages("blastula")
install.packages("rJava")
install.packages("mailR")
install.packages("gmailr")
PASS<- as.character("chopper210397")
library(gmailr)
########################## gmailr ####################################
text_msg <- gm_mime() %>%
  gm_to("luisbarrios2197@gmail.com") %>%
  gm_from("luisbarrios2197@gmail.com") %>%
  gm_text_body("Gmailr is a very handy package!")
######################################################################

send.mail(from = "luisbarrios2197@gmail.com",
          to = "luisbarrios2197@gmail.com",
          subject = "Lansier",
          body = "<b style = 'color:green;'>Vendedor: </b> Ricardo Chimpén
          <br> <b style = 'color:green;'>Producto: </b> Floril Office 
          <br> <b style = 'color:green;'>Cuota realizada: </b> 50% <br>" ,
          html = TRUE,
          smtp = list(host.name="smtp.gmail.com",
                        port=465,  
                      user.name="luisbarrios2197",
                      passwd=PASS,
                      ssl= TRUE),
          authenticate = TRUE,
          send = TRUE)

#puede ser que el antivirus este interfiriendo

##### con este codigo llega a spam #############

send.mail(from = "luisbarrios2197@gmail.com",
          to = "luisbarrios2197@gmail.com",
          subject = "spammmmmmmmmmm",
          body = "Body of the email",
          smtp = list(host.name = "aspmx.l.google.com", port = 25,
                      user.name="luisbarrios2197",
                      passwd=PASS),
          authenticate = TRUE,
          send = TRUE)


####### GUARDANDO IMAGEN ######
jpeg(file="imagen1.jpeg")
ggplot(data = data, mapping = aes(x = Total ,y=Premium))+geom_line()
dev.off()

########################  ENVIAR EMAIL  #################################
PASS<- as.character("chopper210397")

send.mail(from = "luisbarrios2197@gmail.com",
          to = c("luisbarrios2197@gmail.com"),
          subject = "Lansier",
          body = "Body",
          smtp = list(host.name="smtp.gmail.com",
                      port=465,
                      user.name="luisbarrios2197",
                      passwd="chopper210397",
                      ssl=FALSE),
          authenticate = TRUE,
          attach.files = c("imagen1.jpeg"),
          send = TRUE)

