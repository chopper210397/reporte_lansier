install.packages(c("rvest", "RSelenium", "robotstxt", "polite", "dplyr"))
library(rvest)
library(RSelenium)
library(robotstxt)
library(polite)
library(dplyr)


#leyendo data de la web de inretail
read_html("https://b2b.intercorpretail.pe/FPSAV/BBRe-commerce/main")

paths_allowed(domain = "https://b2b.intercorpretail.pe/FPSAV/BBRe-commerce/main")

bow(url = "https://luzpar.netlify.app") %>%
  scrape() %>%
  html_elements(css = "#title a") %>% 
  html_text()



##########################################################
rD=rsDriver()
remDr = rD[["client"]]

remDr$navigate("https://stat385.thecoatlessprofessor.com")

webElem= remDr$findElement(using="class",value="archive-item-link")

webElem$highlightElement()

webElem$getElementAttribute("text")

remDr$navigate("http://www.google.com/ncr")

webElem = remDr$findElement(using="css","[name="q"]")

webElem$sendKeysToElement(list("STAT 285UIUC "))

webElem$sendKeysToElement(list(key="enter"))










