# 2.1 CaracterC-sticas de los objetos (str sobre df, summary, head y view) y funciones

# FunciC3n str

# str es una funciC3n que muestra de manera compacta la estructura interna 
# de un objeto de R. Por ejemplo, si usamos como argumento de str el 
# conjunto de datos iris que podemos encontrar en R

str(iris)

# entonces la salida de la instrucciC3n nos muestra el tipo de objeto, 
# nC:mero de observaciones y de variables, asC- como el tipo de dato al 
# que corresponde cada variable.

# FunciC3n summary

# La funciC3n summary es una funciC3n genC)rica usada para obtener resumenes 
# de diferentes objetos de R, por ejemplo

summary(1:100)
summary(mtcars)

# TambiC)n es C:til para obtener resumenes de los resultados de diferentes
# ajustes a modelos

set.seed(57)
x <- rnorm(35)
e <- rnorm(35)
y <- 5 + 2*x + e
modelo <- lm(y~x)
summary(modelo)

# FunciC3n head

# La funciC3n head devuelve la primera parte de un data frame, tabla, 
# matriz, vector o funciC3n. Por ejemplo, al usar el data frame mtcars
# como argumento de la funciC3n head, se devolverC!n C:nicamente las
# primeras seis filas del data frame

head(mtcars)

# la funciC3n tail funciona de manera similar, pero en lugar de devolver
# la primera parte de un objeto, devuelve la C:ltima parte de este,
# por ejemplo, al ejecutarse la siguiente instrucciC3n

tail(mtcars)

# se devolverC!n las C:ltimas seis filas del data frame

# FunciC3n view

# La funciC3n View aplicada a un objeto de R como un data frame, 
# invoca un visor de datos al estilo de una hoja de cC!lculo, por ejemplo

View(iris)

# FunciC3n que calcula la moda

# En R tambiC)n podemos crear nuestras propias funciones, por ejemplo

moda <- function(vector){
f.abs <- table(vector) # frecuencias absolutas
max.f.abs <- max(f.abs) # obtenemos la mC!xima frecuencia absoluta
pos.max <- which(f.abs == max.f.abs) # posiciC3n(es) de la(s) mC!xima(s) frecuencia(s) absoluta(s)
print("La(s) moda(s) es(son): ")
print(names(f.abs[pos.max]))
paste("Con una frecuencia de: ", unique(as.vector(f.abs[pos.max])))
}

x <- sample(1:100, 100, replace = T) # Tomamos una muestra aleatoria de tamaC1o 100 con reemplazo de los primeros 100 nC:meros naturales
table(x) # obtenemos las frecuencias absolutas de los valores de la muestra
moda(x) # obtenemos la moda de los valores de la muestra
y <- sample(1:1000, 1000, replace =T)
moda(y)
