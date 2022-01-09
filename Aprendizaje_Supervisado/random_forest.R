#RANDOM FOREST MODEL
library(tidyverse)
library(caret)
library(ranger)

random_forest_prediction<-function(datos){
  
  #Elegimos un método de control de entrenamiento (loocv,k-fold cv, boot, ...)
  trControl_rcv <- trainControl(method = "repeatedcv", repeats= 1 , number=5, allowParallel=TRUE)

  #Aplicar random forest
  RF_MODEL <- train(price ~  kms_driven + cilindrada + BHP  + owner + model_year + consumption,
                    data = datos, 
                    method = "rf",
                    trControl = trControl_rcv, 
                    tuneLength = 4
                    )
  
  return (RF_MODEL)
}