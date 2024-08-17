# generamos un dataset dummy con información diaria que indica si llovío o no
fechas <- seq(as.Date('2024-01-01'), as.Date('2024-08-16'), by = "day")
llovio <- sample(c(0,1), 229, replace = T)
dataset <- data.frame(dia = fechas, llovio = llovio)
# convertir esta información a un objeto tipo time series
llovio_ts <- ts(dataset$llovio, start = c(2024,1), frequency = 365) # con el 365 le estamos diciendo que es una serie diaria
# hacer una gráfica de autocorrelación
acf(llovio_ts)
# ajustamos un modelo arima, en este ejemplo de orden (1,1,1)
modelo <- arima(llovio_ts, order = c(4,1,1)) # order = (AR,I,MA)
# Hacer una predicción para el día de hoy
pred <- predict(modelo, 10)
# construimos un intervalo de confianza de nuestra predicción
lim_inf <- pred$pred - pred$se
lim_sup <-pred$pred + pred$se
# Visualización
plot(llovio_ts)
 # usando ggplot
library(ggplot2)
ggplot(dataset) + 
  geom_line(aes(x = dia,y = llovio,group = 1))
ts.plot(llovio_ts, pred$pred, lty = c(1,3), col = c(5,2))
# usando package forecast
library(forecast)
modelo1 <- Arima(llovio_ts, order = c(4,1,1))
pronostico <- forecast(modelo1,30)
plot(pronostico)
######################################################################
######################################################################
######################################################################
# DESCOMPOSICIÓN DE UNA SERIE DE TIEMPO
# 2 tipos de descomposiciones:
# aditiva: yi = Ti + Ei + ri # Tendencia + Estacionalidad + Ruido
# multiplciativa: yi = Ti*Ei*ri (tendencia*estacionalidad*ruido)
# generamos un dataset dummy
fechas <- seq(as.Date('2022-01-01'), as.Date('2024-07-31'), by = "day")
ventas <- runif(943, 0, 10000)
dataset <- data.frame(dia = fechas, venta = ventas)
# convertir a tipo time series
ts_ventas <- ts(dataset$venta, start = c(2022,1), frequency = 365)
# podemos ahcer gráficas para visualizar nuestra serie de tiempo
plot(ts_ventas)
# descomposición aditiva
dec <- decompose(ts_ventas)
plot(dec)
# una cosa que podemos hacer, es pasar de dia a mes
library(dplyr)
library(lubridate)
mensual <- dataset %>%
  mutate(mes = floor_date(dia, "month")) %>%
  group_by(mes) %>%
  summarize(venta = sum(venta))
ts_ventas_mensual <- ts(mensual$venta, start = c(2022,1), frequency = 12)
# Visualizamos nuestra serie de tiempo mensual
plot(ts_ventas_mensual)
dec_mensual <- decompose(ts_ventas_mensual)
plot(dec_mensual)
