# Paquetes necesarios
# install.packages("R.utils")
# install.packages("tidyverse")
# install.packages("VIM")

# Carga de librerias
library("tidyverse")
library("dplyr")
library("ggplot2")
library("stringi")
library("VIM")

# Importamos los archivos de preprocesado de las columnas
source("Name.r")
source("Kms_driven.r")
source("Consumption.r")
source("Location.r")
source("Bhp.r")
source("Owner.r")
source("NaReplacement.r")

#Carga de Datos
# Lee fichero datasets/dataset.csv
datos <- read.csv("../Datos/bikes.csv", sep=",")
# Mostramos los datos originales
head(datos)

print("")
print("START")
print("")
#########################
# ETAPA DE PREPROCESADO #
#########################

#Renombramos las columnas de los datos originales
names(datos)[names(datos) == 'mileage'] <- 'consumption'
names(datos)[names(datos) == 'power'] <- 'BHP'
names(datos)[names(datos) == 'model_name'] <- 'model'

datos = preprocesarColumnaName(datos);
datos = preprocesarColumnaConsumption(datos);
datos = preprocesarColumnaKmsDriven(datos);
datos = preprocesarColumnaLocation(datos);
datos = preprocesarColumnaBHP(datos);
datos = preprocesarColumnaOwner(datos);
datos = tratarNaValues(datos);

print("")
print("END");
print("")
# Mostrmos el resultado
head(datos)

# Guardamos el resultado
write.csv(datos,"../Datos/bikes_preprocess.csv")