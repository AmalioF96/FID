library(readr)
library(tidyr)
library(cluster)
library(factoextra)
library(dplyr)
bikes_preprocess <- read_csv("Datos/bikes_preprocess.csv")
numCusters <- 5
kmeans_preparation <- data.frame(bikes_preprocess[,2:4], bikes_preprocess[,6:9], bikes_preprocess[,11])

kmeans_preparation[,8] <- 1 * kmeans_preparation[,8]

avg_kmdriven <- round(mean(kmeans_preparation$kms_driven, trim = 0, na.rm = TRUE))
avg_consumption <- round(mean(kmeans_preparation$consumption, trim = 0, na.rm = TRUE))
avg_bhp <- round(mean(kmeans_preparation$BHP, trim = 0, na.rm = TRUE))
avg_cilindrada <- round(mean(kmeans_preparation$cilindrada, trim = 0, na.rm = TRUE))
kmeans_preparation$kms_driven <- replace_na(kmeans_preparation$kms_driven, avg_kmdriven)
kmeans_preparation$consumption <- replace_na(kmeans_preparation$consumption, avg_consumption)
kmeans_preparation$BHP <- replace_na(kmeans_preparation$BHP, avg_bhp)
kmeans_preparation$cilindrada <- replace_na(kmeans_preparation$cilindrada, avg_cilindrada)

# Muestreo Aleatorio
muestreo <- sample_n(kmeans_preparation, size= 1000)
# Determinar numero de clusters en base al muestreo
fviz_nbclust(muestreo, kmeans,method = "wss")

clusters <- kmeans(kmeans_preparation, numCusters)
clusters
sil <- silhouette(clusters$cluster, dist(kmeans_preparation))
fviz_silhouette(sil)
kmeans_preparation$Cluster <- as.factor(clusters$cluster)
bikes_preprocess$Cluster <- as.factor(clusters$cluster)
str(clusters)

avg_clu_kmsdriven <- vector()
avg_clu_consumption <- vector()
avg_clu_bhp <- vector()
avg_clu_cilindrada <- vector()
avg_clu_price <- vector()

for (i in 1:numCusters) {
  avg_clu_kmsdriven[i] <- mean(kmeans_preparation[kmeans_preparation$Cluster == i,]$kms_driven)
  avg_clu_consumption[i] <- mean(kmeans_preparation[kmeans_preparation$Cluster == i,]$consumption)
  avg_clu_bhp[i] <- mean(kmeans_preparation[kmeans_preparation$Cluster == i,]$BHP)
  avg_clu_cilindrada[i] <- mean(kmeans_preparation[kmeans_preparation$Cluster == i,]$cilindrada)
  avg_clu_price[i] <- mean(kmeans_preparation[kmeans_preparation$Cluster == i,]$price)
}

for ( i in 1:numCusters) {
  bikes_preprocess$kms_driven[bikes_preprocess$Cluster == i] <- replace_na(bikes_preprocess$kms_driven[bikes_preprocess$Cluster == i], avg_clu_kmsdriven[i])
  bikes_preprocess$consumption[bikes_preprocess$Cluster == i] <- replace_na(bikes_preprocess$consumption[bikes_preprocess$Cluster == i], avg_clu_consumption[i])
  bikes_preprocess$BHP[bikes_preprocess$Cluster == i] <- replace_na(bikes_preprocess$BHP[bikes_preprocess$Cluster == i], avg_clu_bhp[i])
  bikes_preprocess$cilindrada[bikes_preprocess$Cluster == i] <- replace_na(bikes_preprocess$cilindrada[bikes_preprocess$Cluster == i], avg_clu_cilindrada[i])
}


write.table(bikes_preprocess,"Datos/unsupervised_learning_result.csv", row.names = FALSE, dec=',', sep=';')
