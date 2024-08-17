# Desarrollo

# Comenzando con gráficos simples; vamos a utilizar el dataset mtcars.

# Instalamos el paquete (si es necesario) y lo cargamos

library(ggplot2)

# Primero recordamos cuales son las variables que contiene el dataset

names(mtcars)
str(mtcars)
summary(mtcars)
# Graficamos las variables cyl en el eje x y hp en y, observa el comando geom_point()

ggplot(mtcars, aes(x=cyl, y = hp, colour = mpg)) + 
  geom_point()  # Tipo de geometría, intenta utilizar alguna otra
ggplot(mtcars) + 
  geom_boxplot(aes(x=cyl, y = hp, group = cyl)) +
  ggtitle("Caja de brazos por # de cilindros")

# Agregando carácteristicas de tema y facetwrap

names(mtcars)
ggplot(mtcars, aes(x=cyl, y = hp, colour = mpg)) + 
  geom_point() +   
  theme_gray() +   # Temas (inteta cambiarlo)
  facet_wrap("am")  # Lo divide por am

ggplot(mtcars, aes(x=cyl, y = hp, group = cyl)) + 
  geom_boxplot() +   
  theme_gray() +   # Temas (inteta cambiarlo)
  facet_wrap("am", ncol = 1)

# Agregando nombres a los ejes x, y

names(mtcars)
ggplot(mtcars, aes(x = cyl, y = hp, colour = mpg )) + 
  geom_point() +   
  theme_gray() +   # Temas (inteta cambiarlo)
  facet_wrap("cyl") +  # Lo divide por el núm de cilindros
  xlab('Núm de cilindros') +  # Nombre en los ejes
  ylab('Caballos de Fuerza') +
  ggtitle("Gráfico de dispersión cyl vs hp por cyl")

# Adicionalmente se pueden realizar otros tipos de gráficos, estos se verán en los próximos ejemplos.