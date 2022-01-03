library(readr)
bikes_preprocess <- read_csv("Datos/bikes_preprocess.csv")
kmeans_preparation <- data.frame(bikes_preprocess[,3:5], bikes_preprocess[,7:10], bikes_preprocess[,12])

kmeans_preparation[,8] <- 1 * kmeans_preparation[,8]

kmeans_preparation <- na.omit(kmeans_preparation)

View(kmeans_preparation)

clusters <- kmeans(kmeans_preparation, 5)
kmeans_preparation$Cluster <- as.factor(clusters$cluster)
str(clusters)

View(kmeans_preparation)
