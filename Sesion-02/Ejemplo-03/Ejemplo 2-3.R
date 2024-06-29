# 2.3 Paquete dplyr y aplicaciones

# El paquete dplyr cuenta con varias funciones muy C:tiles, para manipular 
# y transformar data frames. Una vez instalado el paquete dplyr puede cargarlo
# en R de la siguiente manera (Sin mensajes ni advertencias)
#install.packages('dplyr')
suppressMessages(suppressWarnings(library(dplyr)))

# Vamos a descargar archivos csv que contienen datos del covid-19 para mostrar
# como funcionan algunas funciones del paquete dplr. Las url desde las
# cuales descargamos los datos son las siguientes

url1 <- "https://data.humdata.org/hxlproxy/data/download/time_series_covid19_confirmed_global_narrow.csv?dest=data_edit&filter01=explode&explode-header-att01=date&explode-value-att01=value&filter02=rename&rename-oldtag02=%23affected%2Bdate&rename-newtag02=%23date&rename-header02=Date&filter03=rename&rename-oldtag03=%23affected%2Bvalue&rename-newtag03=%23affected%2Binfected%2Bvalue%2Bnum&rename-header03=Value&filter04=clean&clean-date-tags04=%23date&filter05=sort&sort-tags05=%23date&sort-reverse05=on&filter06=sort&sort-tags06=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_confirmed_global.csv"
url2 <- "https://data.humdata.org/hxlproxy/data/download/time_series_covid19_deaths_global_narrow.csv?dest=data_edit&filter01=explode&explode-header-att01=date&explode-value-att01=value&filter02=rename&rename-oldtag02=%23affected%2Bdate&rename-newtag02=%23date&rename-header02=Date&filter03=rename&rename-oldtag03=%23affected%2Bvalue&rename-newtag03=%23affected%2Binfected%2Bvalue%2Bnum&rename-header03=Value&filter04=clean&clean-date-tags04=%23date&filter05=sort&sort-tags05=%23date&sort-reverse05=on&filter06=sort&sort-tags06=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_deaths_global.csv"

# Descargamos los datos en nuestro directorio de trabajo con la siguiente instrucciC3n

download.file(url = url1, destfile = "st19ncov-confirmados.csv", mode = "wb")
download.file(url = url2, destfile = "st19ncov-muertes.csv", mode = "wb")

# Una vez que hemos descargado los datos importamos los datos de casos
# confirmados y muertes a R

conf <- read.csv("st19ncov-confirmados.csv")
mu <- read.csv("st19ncov-muertes.csv")

str(conf); str(mu)
head(conf); head(mu)

# Ahora seleccionamos todas las filas menos la primera, esto para cada
# data frame

Sconf <- conf[-1,]
Smu <- mu[-1,]

# Con la funciC3n select del paquete dplyr, del data frame de casos confirmados
# seleccionamos C:nicamente las columnas de PaC-s, Fecha, NC:mero acumulado de casos

Sconf <- select(Sconf, Country.Region, Date, Value) # PaC-s, fecha y acumulado de infectados
Sconf1 <- Sconf %>%
  select(Country.Region, Date, Value) 
  
# Con la funciC3n rename, renombramos las columnas correspondientes al paC-s
# y al nC:mero acumulado de casos de infectados por covid-19

Sconf2 <- Sconf %>%
  select(Country.Region, Date, Value) %>%
  rename(Pais = Country.Region, Fecha = Date, Infectados = Value)

str(Sconf)

# Como cada una de las columnas del C:ltimo data frame aparecen como factor,
# con la funciC3n mutate transformamos las columnas correspondientes a fechas
# y a nC:mero de infectados, esto para que R reconozca como fechas la 
# columna correspondiente y como nC:meros los elementos de la columna que 
# indica el acumulado de casos.
#Sconf2["tipo_fecha"] <- as.Date(Sconf2$Fecha) #sto de aqui se escribe m??s f??cil

Sconf3 <- Sconf %>%
  select(Country.Region, Date, Value) %>%
  rename(Pais = Country.Region, Fecha = Date, Infectados = Value) %>%
  mutate(Fecha = as.Date(Fecha, "%Y-%m-%d"), Infectados = as.numeric(Infectados))

# Hacemos algo similar con el data frame correspondiente al nC:mero
# acumulado de muertos

Smu <- select(Smu, Country.Region, Date, Value) # Seleccionamos paC-s, fecha y acumulado de muertos
Smu <- rename(Smu, Pais = Country.Region, Fecha = Date, Muertos = Value) # Renombramos
Smu <- mutate(Smu, Fecha = as.Date(Fecha, "%Y-%m-%d"), Muertos = as.numeric(Muertos)) # Transformamos

Smu3 <- Smu %>%
  select(Country.Region, Date, Value) %>%
  rename(Pais = Country.Region, Fecha = Date, Muertos = Value) %>%
  mutate(Fecha = as.Date(Fecha, "%Y-%m-%d"), Muertos = as.numeric(Muertos))

Scm <- merge(Sconf3, Smu3, by.x = c("Pais", "Fecha"), by.y = c("Pais", "Fecha"), all = F) # Unimos infectados y muertos acumulados para cada fecha

Scm <- Sconf %>%
  select(Country.Region, Date, Value) %>%
  rename(Pais = Country.Region, Fecha = Date, Infectados = Value) %>%
  mutate(Fecha = as.Date(Fecha, "%Y-%m-%d"), Infectados = as.numeric(Infectados)) %>%
  merge(Smu %>%
          select(Country.Region, Date, Value) %>%
          rename(Pais = Country.Region, Fecha = Date, Muertos = Value) %>%
          mutate(Fecha = as.Date(Fecha, "%Y-%m-%d"), Muertos = as.numeric(Muertos)))

mex <- filter(Scm, Pais == "Mexico") # Seleccionamos sC3lo a MC)xico
mex <- filter(mex, Infectados != 0) # Primer dC-a de infectados
# o
mex <- Scm %>%
  filter(Pais == "Mexico", Infectados != 0)
# mex <- mutate(mex, Infectados = as.numeric(Infectados), Muertos = as.numeric(Muertos))

mex <- mutate(mex, NI = c(1, diff(Infectados))) # Nuevos infectados por dC-a
mex <- mutate(mex, NM = c(0, diff(Muertos))) # Nuevos muertos por dC-a

mex <- mutate(mex, Letalidad = round(Muertos/Infectados*100, 1)) # Tasa de letalidad

mex <- mutate(mex, IDA = lag(Infectados), MDA = lag(Muertos)) # Valores dC-a anterior
mex <- mutate(mex, FCI = Infectados/IDA, FCM = Muertos/MDA) # Factores de Crecimiento
mex <- mutate(mex, Dia = 1:dim(mex)[1]) # DC-as de contingencia

head(mex); tail(mex)
write.csv(mex, "C19Mexico.csv", row.names = FALSE)

# Nota: en el ejemplo 5 de la sesiC3n 3 se harC! uso del archivo creado C19Mexico.csv
