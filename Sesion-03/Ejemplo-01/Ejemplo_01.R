# Desarrollo

# Comenzando con gráficos simples; vamos a utilizar el dataset mtcars.

# Instalamos el paquete (si es necesario) y lo cargamos

library(ggplot2)

# Primero recordamos cuales son las variables que contiene el dataset

names(mtcars)

# Graficamos las variables cyl en el eje x y hp en y, observa el comando geom_point()

ggplot(mtcars, aes(x=cyl, y = hp, colour = mpg )) + 
  geom_point() +
  geom_line(aes()) 
# Tipo de geometría, intenta utilizar alguna otra
ggplot(mtcars) +
  geom_point(aes(x= cyl, y = hp, colour = mpg)) +
  geom_line(aes())
# Agregando carácteristicas de tema y facewrap

names(mtcars)
ggplot(mtcars, aes(x=carb, y = hp, colour = mpg )) + 
  geom_point() +   
  theme_gray() +   # Temas (inteta cambiarlo)
  facet_wrap("cyl")  # Lo divide por el núm de cilindros

# Agregando nombres a los ejes x, y
library(dplyr)
names(mtcars)
data(mtcars)
my_mtcars <- mtcars
my_mtcars <- my_mtcars %>%
  mutate(nombre = row.names(my_mtcars))

ggplot(my_mtcars, aes(x = cyl, y = hp, colour = mpg ))+
  geom_text(aes(label = nombre), vjust = -0.5) + 
  geom_point() +   
  theme_gray() +   # Temas (inteta cambiarlo)
  #facet_wrap("cyl") +  # Lo divide por el núm de cilindros
  xlab('Núm de cilindros') +  # Nombre en los ejes
  ylab('Caballos de Fuerza') 
ggplot(mtcars)
# Adicionalmente se pueden realizar otros tipos de gráficos, estos se verán en los próximos ejemplos.