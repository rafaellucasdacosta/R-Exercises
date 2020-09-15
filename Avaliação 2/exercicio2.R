library("ggplot2")
library(readr)
covidPopulacao <- read_delim("covidPopulacao.csv", ";", escape_double = FALSE, trim_ws = TRUE)

ggplot(covidPopulacao, aes(Pais, Percentual, label = Percentual)) + geom_bar(stat = "identity") + geom_text(size = 6)
