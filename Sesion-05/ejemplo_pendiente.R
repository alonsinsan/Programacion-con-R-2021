# Ejemplo con fechas
datos <- data.frame(fecha = seq(as.Date("2024-01-01"), length.out = 180, by ="day"),
                    precio = rnorm(180, 173,10))

modelo <- lm(precio~fecha, data =datos)
summary(modelo)

ggplot(datos, aes(x=fecha, y = precio)) + 
  geom_line(aes(group = 1))+
  geom_smooth(method = "lm")

# agregar características
# año, mes , dia, día de la semana, semana del año, trimestre del año, dia del año, holidays
datos2 <- datos %>%
  mutate(año =
           , mes = 
           , dia = 
           , dia_semana =
           , ...)

modelo2 <- lm(precio~., data = datos2)