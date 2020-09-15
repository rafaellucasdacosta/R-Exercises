library("ggplot2")
library(readr)
covidPopulacao <- read_delim("covidPopulacao.csv", ";", escape_double = FALSE, trim_ws = TRUE)

ggplot(covidPopulacao, aes(Pais, Mortos, label = Mortos)) + geom_bar(stat = "identity") + geom_text(size = 6)
