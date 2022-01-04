#RANDOM FOREST MODEL
library(tidyverse)
library(caret)

random_forest_prediction<-function(datos){
  #semilla para reproducibilidad
  set.seed(1234)
  
  #Omitimos valores nulos
  datos <- datos %>% na.omit()
  
  #Dividimos el conjunto de datos de entrenamiento y testing
  partition <- createDataPartition(datos$price, p = 0.75, list = FALSE)
  
  #entrenamiento
  training <- datos[partition, ]
  
  #validación
  testing  <- datos[-partition, ]
  
  #Elegimos un método de control de entrenamiento (loocv,k-fold cv, boot, ...)
  trControl_rcv <- trainControl(method  = "repeatedcv", number=10, repeats= 3)

  #Aplicar random forest
  RF_MODEL <- train(price ~  kms_driven + cilindrada + BHP + model_year,
                    data = datos, 
                    method = "ranger", 
                    trControl = trControl_rcv, 
                    tuneLength = 15
                    )
  
  #RF_MODEL
  
  #plot(RF_MODEL)
  
  #RF_PRED <- predict(RF_MODEL,newdata = testing)
  
  #Mostrar medidas
  #evaluacion_rf <- postResample(pred = RF_PRED, obs = testing$price)
  #evaluacion_rf
  
  #RETURN MEDIA DE ERRORES
  return (RF_MODEL)
}