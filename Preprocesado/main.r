# Paquetes necesarios
# install.packages("R.utils")
# install.packages("tidyverse")

# Carga de librerias
library("tidyverse")
library("dplyr")
library("ggplot2")
library("stringi")

# Importamos los archivos de preprocesado de las columnas
source("Name.r")
source("Kms_driven.r")
source("Consumption.r")

#Carga de Datos
# Lee fichero datasets/dataset.csv
datos <- read.csv("../Datos/bikes.csv", sep=",")
# Mostramos los datos originales
head(datos)

print("")
#########################
# ETAPA DE PREPROCESADO #
#########################

#Renombramos las columnas de los datos originales
names(datos)[names(datos) == 'mileage'] <- 'consumption'
names(datos)[names(datos) == 'power'] <- 'BHP'

datos = preprocesarColumnaName(datos);
datos = preprocesarColumnaConsumption(datos);
datos = preprocesarColumnaKmsDriven(datos);

print("");

# Mostrmos el resultado
head(datos)

# Guardamos el resultado
write.csv(datos,"../Datos/bikes_preprocess.csv")