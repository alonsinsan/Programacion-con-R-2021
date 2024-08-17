library(dplyr)
# vamos a trbajar con el dataset de iris
View(iris)
# group by - summarize
resultados <- iris %>%
  group_by(Species) %>%
  summarize(media_petal_length = mean(Petal.Length)
            , sd_petal_length = sd(Petal.Length)
            , sd_sepal_width = sd(Sepal.Width))
