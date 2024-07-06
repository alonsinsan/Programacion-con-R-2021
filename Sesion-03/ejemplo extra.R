library(dplyr)

datos <- read.csv('Data/dummy.csv')

summary(datos)
datos <- datos %>%
  mutate(semana = as.Date(semana)
         , id_client = factor(id_client))

resumen1 <- datos %>%
  group_by(semana) %>%
  summarize(n_cliente = n_distinct(id_client))

resumen2 <- datos %>%
  mutate(categoria_riesgo = ifelse(probabilidad<0.7, "baja", ifelse(probabilidad < 0.85, "media", "alta"))) %>%
  group_by(semana, categoria_riesgo) %>%
  summarize(n_clientes = n_distinct(id_client)) %>%
  tidyr::pivot_wider(names_from = "categoria_riesgo", values_from = "n_clientes")
