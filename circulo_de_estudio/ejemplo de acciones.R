library(BatchGetSymbols)
library(ggplot2)
# 1. Explorar la serie de tiempo de acciones de Google, y ajustarle un modelo lineal para determinar tendencia

# 2. Dataset a trabajar (mostrar el dataset y limpiarlo o transformar)

datos <- BatchGetSymbols(c("GOOG")
                         , first.date = Sys.Date() - 229
                         , last.date = Sys.Date()-1
                         , freq.data = 'daily')
precios <- datos$df.tickers %>%
  select(fecha = ref.date, precio_cierre = price.close)

# 3. Exploratorio de datos es apuntando a la pregunta inicial
# Visualización de la serie de tiempo
ggplot(precios) + 
  geom_line(aes(x = fecha, y = precio_cierre, group = 1)) + 
  ggtitle("Precio de cierre de acción de Google")


# 4. Modelo escogido entre (pruebas de hipotesis, regresión lineal, análisis de series de tiempo)
modelo <- lm(precio_cierre ~fecha, data = precios)
summary(modelo)
plot(modelo)

# 5. Conclusiones
# La tendencia lineal es un modelo muy básico para describir todo el comportamiento de las acciones
# COrriendo el modelo lineal sobre estos datos para obtener una tendencia de crecimiento
# obtenemos una pendiente de 0.2029 que quiere decir que en el año cda día la acción aumenta en 0.2029 USD
modelo$coefficients



