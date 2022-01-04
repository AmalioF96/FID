#PARTE I: APRENDIZAJE SUPERVISADO

#OBJETIVO: Cálculo del precio estimado de una motocicleta dadas unas variables influyentes, llamadas predictoras.
############################################################################################
library(tidyverse)
library(caret)
library(GGally)
library(dplyr)
#SCRIPT PARA MODEL DE REGRESIÓN LINEAL MÚLTIPLE
source("./Aprendizaje_supervisado/lineal_multiple.R")
source("./Aprendizaje_supervisado/knn.R")
source("./Aprendizaje_supervisado/random_forest.R")

#semilla
set.seed(1234)

#Reiniciar variables de entorno
#rm(list = ls())

#Obtención de los datos una vez preprocesados
datos <- read.csv("./Datos/bikes_preprocess.csv",header = TRUE, sep=",")
datos$X<-NULL
#Muestra de los datos
head(datos)
#Dimension de los datos
dim(datos)
str(datos)

#Omitimos valores nulos (QUITAR)
datos <- datos %>% na.omit()

########## MUESTRA DE CORRELACION VARIABLE A VARIABLE

datos %>% ggplot() + aes(model_year,price) + geom_point()
datos %>% ggplot() + aes(kms_driven,price) + geom_point()
datos %>% ggplot() + aes(owner,price) + geom_point()
datos %>% ggplot() + aes(consumption,price) + geom_point()
datos %>% ggplot() + aes(BHP,price) + geom_point()
datos %>% ggplot() + aes(cilindrada,price) + geom_point()

##########

#Vemos correlación entre las variables, quitando variables no numéricas
datos_correlacion <- datos %>% select(-c(model,location,brand,isElectric))

# MUESTRA DE CORRELACION DE TODAS LAS VARIABLES
ggpairs(datos_correlacion, lower = list(continuous = "smooth"),
        diag = list(continuous = "barDiag"), axisLabels = "none")
#se podría hacer mediante caret, con la función step()

#particion
partition <- createDataPartition(datos_correlacion$price, p = 0.75, list = FALSE)
#entrenamiento
training <- datos_correlacion[partition, ]
#validación
testing  <- datos_correlacion[-partition, ]

MLR_MODEL <- multiple_regresion_prediction(training)
KNN_MODEL <- knn_prediction(training)
RF_MODEL <- random_forest_prediction(training)

MLR_PRED <- predict(MLR_MODEL, newdata = testing)
KNN_PRED <- predict(KNN_MODEL, newdata = testing)
RF_PRED <- predict(RF_MODEL, newdata = testing)

#Mostrar medidas
evaluacion_lm <- postResample(pred = MLR_PRED, obs = testing$price)
evaluacion_lm

evaluacion_knn <- postResample(pred = KNN_PRED, obs = testing$price)
evaluacion_knn

evaluacion_rf <- postResample(pred = RF_PRED, obs = testing$price)
evaluacion_rf
