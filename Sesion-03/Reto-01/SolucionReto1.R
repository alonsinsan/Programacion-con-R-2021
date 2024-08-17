
# Lectura de los datos
library(ggplot2)
data <- read.csv("Reto-01/BD_Altura_Alunos.csv", sep = ";", col.names = c("alumno", "altura")) # camino 1
data2 <- read.csv("Reto-01/BD_Altura_Alunos.csv", sep = ";")
colnames(data2) <- c("alumno", "altura")

data <- as.data.frame(data)
#realizando el histograma con la función hist()
hist(data$Altura, 
     breaks = 20,
     main = " Histograma de alturas",
     ylab = "Frecuencia",
     xlab = "Altura", 
     col = "blue")

#realizando el histograma con la función ggplot()
ggplot(altura, aes(Altura))+ 
  geom_histogram(bins = 20, col="black", fill = "blue") + 
  ggtitle("Histograma de Mediciones") +
  ylab("Frecuencia") +
  xlab("Alturas") + 
  theme_light()
