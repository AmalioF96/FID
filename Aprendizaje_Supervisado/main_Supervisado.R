#PARTE I: APRENDIZAJE SUPERVISADO

#OBJETIVO: Cálculo del precio estimado de una motocicleta dadas unas variables influyentes o predictoras.
############################################################################################
library(tidyverse)
library(caret)
library(GGally)
library(dplyr)

#Reiniciar variables de entorno
rm(list = ls())

#semilla
set.seed(1234)

#SCRIPT PARA MODEL DE REGRESIÓN LINEAL MÚLTIPLE
source("./Aprendizaje_supervisado/lineal_multiple.R")
source("./Aprendizaje_supervisado/knn.R")
source("./Aprendizaje_supervisado/random_forest.R")

#Obtención de los datos una vez preprocesados
datos <- read.csv("./Datos/unsupervised_learning_result.csv",header = TRUE, sep=";",dec=",")

summary(datos)

#Muestra de los datos
head(datos)
#Dimension de los datos
dim(datos)
str(datos)

##########

#Vemos correlación entre las variables, quitando variables no numéricas
datos_correlacion <- datos %>% select(-c(model,location,brand,isElectric, Cluster))

#Nos cercioramos de que las variables son numéricas y están cargadas correctamente
datos_correlacion %>% select_if(negate(is.numeric))

#Mostrar valor de la correlación variable a variable, valor sin gráfica
cor(datos_correlacion$model_year, datos_correlacion$price, method = c("pearson", "kendall", "spearman"))
cor(datos_correlacion$kms_driven, datos_correlacion$price, method = c("pearson", "kendall", "spearman"))
cor(datos_correlacion$owner, datos_correlacion$price, method = c("pearson", "kendall", "spearman"))
cor(datos_correlacion$consumption, datos_correlacion$price, method = c("pearson", "kendall", "spearman"))
cor(datos_correlacion$BHP, datos_correlacion$price, method = c("pearson", "kendall", "spearman"))
cor(datos_correlacion$cilindrada, datos_correlacion$price, method = c("pearson", "kendall", "spearman"))

########## MUESTRA DE CORRELACION VARIABLE A VARIABLE

datos_correlacion %>% ggplot() + aes(model_year,price) + geom_point()
datos_correlacion %>% ggplot() + aes(kms_driven,price) + geom_point()
datos_correlacion %>% ggplot() + aes(owner,price) + geom_point()
datos_correlacion %>% ggplot() + aes(consumption,price) + geom_point()
datos_correlacion %>% ggplot() + aes(BHP,price) + geom_point()
datos_correlacion %>% ggplot() + aes(cilindrada,price) + geom_point()

# MUESTRA DE CORRELACION DE TODAS LAS VARIABLES A MODO DE VISTA GENERAL
ggpairs(datos_correlacion, lower = list(continuous = "smooth"),
        diag = list(continuous = "barDiag"), axisLabels = "none")

#particion
partition <- createDataPartition(datos_correlacion$price, p = 0.75, list = FALSE)
#entrenamiento
training <- datos_correlacion[partition, ]
#validación
testing  <- datos_correlacion[-partition, ]

#MODELO MLR
MLR_MODEL <- multiple_regresion_prediction(training)
MLR_PRED <- predict(MLR_MODEL, newdata = testing)

#MODELO RF
RF_MODEL <- random_forest_prediction(training)
RF_PRED <- predict(RF_MODEL, newdata = testing)

#Mostrar medidas obtenidas
evaluacion_lm <- postResample(pred = MLR_PRED, obs = testing$price)
evaluacion_lm

evaluacion_rf <- postResample(pred = RF_PRED, obs = testing$price)
evaluacion_rf


#Normalizamos los datos de entrada
datos_correlacion_knn <- datos_correlacion %>% mutate_each_(list(~scale(.) %>% as.vector),
                                  vars = c("kms_driven","model_year","BHP","consumption","cilindrada","owner","price"))

#particion knn
partition_knn <- createDataPartition(datos_correlacion_knn$price, p = 0.75, list = FALSE)
#entrenamiento knn
training_knn <- datos_correlacion_knn[partition_knn, ]
#validación knn
testing_knn  <- datos_correlacion_knn[-partition_knn, ]


#MODELO KNN
KNN_MODEL <- knn_prediction(training_knn)
KNN_PRED <- predict(KNN_MODEL, newdata = testing_knn)

evaluacion_knn <- postResample(pred = KNN_PRED, obs = testing_knn$price)
evaluacion_knn
