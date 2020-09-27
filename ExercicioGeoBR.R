library(sf)
library(geobr)
library(ggplot2)
library(data.table)
library(dplyr)

#Grafico do PR
pr <- read_municipality(code_muni = "PR", year = 2019)

#no_axis <- theme(axis.title=element_blank(),
 #                axis.text=element_blank(),
  #               axis.ticks=element_blank())

#Exibe grafico dos municipios do parana
#ggplot(pr)+geom_sf(aes(fill=abbrev_state))

dados <- fread("covid.csv", encoding = "UTF-8", header=T)
casosAtuais <- filter(dados, data=="13/09/2020")
totalPorMunicipio <- filter(casosAtuais, estado == "PR")
totalPorMunicipio <- totalPorMunicipio[-c(1, 2), ]

setnames(totalPorMunicipio, "municipio", "name_muni")

geral <- merge(pr, totalPorMunicipio, by="name_muni")

ggplot(geral)+geom_sf(aes(fill=casosAcumulado))








