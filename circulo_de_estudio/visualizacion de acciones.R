library(quantmod)
inicio <- "2024-04-01"
fin <- "2024-06-30"
getSymbols("GOOG",from = inicio, to = fin, src = "yahoo")
chartSeries(GOOG, type = "matchsticks", name = "Google Stock")
