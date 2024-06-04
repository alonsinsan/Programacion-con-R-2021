library(dplyr)
library(lubridate)
library(tseries)
library(ggplot2)
library(purrr)
library(tidyr)
library(forecast)
###############################################################################
# Funciones
###############################################################################

#------------------------------------------------------------------------------
###############################################################################
# Lectura de datos
###############################################################################
# Vector con los nombres de los archivos en el directorio microsoft stock
archivos <- list.files(path = "microsoft stock", pattern = "*.csv", full.names = T)
# 1. Usando lapply y bind_rows
# usando lapply aplicamos la función read.csv a cada elemento en el vector archivos
list_stocks <- lapply(archivos, read.csv)
# usar rbind a lo largo de los elementos en la lsita para crear un solo df con todos los dfs unidos
df_stocks <- bind_rows(list_stocks)

# 2. Usando purrr::map_df
df_stocks <- map_df(archivos, read.csv)

#------------------------------------------------------------------------------
###############################################################################
# Limpieza de datos y transformaciones
###############################################################################
df_stocks <- df_stocks %>%
  mutate(Date = as.POSIXct(Date, format = "%m/%d/%Y %H:%M:%S",)
         , fecha = ymd(as.Date(Date)))
# ¿cuántas veces aparece cada día en la serie?, ¿existe algún día que aparezca más de 1 vez?
max(df_stocks %>%
  group_by(fecha) %>%
  summarize(n = n()) %>%
  pull(n))

complete_stocks <- df_stocks %>%
  select(fecha, Open, High, Low, Close, Volume) %>%
  merge(data.frame(Date = seq(min(df_stocks$fecha)
                                  , max(df_stocks$fecha)
                                  , by = "day"))
            , by.x = 'fecha', by.y = 'Date', all.y = T) %>%
  fill(Open:Volume, .direction = "down")
 # Verificamos que el tamaño sea correcto
max(df_stocks$fecha) - min(df_stocks$fecha)

#------------------------------------------------------------------------------
###############################################################################
# Exploratorio (¿puedo hacer un pronóstcio para los siguientes 2 años de data?)
################################################################################
summary(complete_stocks)
ggplot(complete_stocks) +
  geom_line(aes(x=fecha, y= Close, group = 1)) +
  ggtitle("Acciones de Microsoft")

#-------------------------------------------------------------------------------
################################################################################
# Time series treatment
################################################################################
# Transformación a serie de tiempo
ts_stocks <- ts(complete_stocks$Close
                , start = c(year(min(complete_stocks$fecha))
                            , month(min(complete_stocks$fecha)))
                , end = c(year(max(complete_stocks$fecha))
                          , month(max(complete_stocks$fecha)))
                , frequency = 365)
deco_ts <- decompose(ts_stocks)
plot(deco_ts)
# Modelo arima
best_arima <- auto.arima(ts_stocks,
                         method = 'CSS',
                         seasonal = T,
                         stepwise = F, 
                         approximation = F,
                         seasonal.test = "ch")
pred <- forecast(best_arima, h = 365)
plot(pred)
