#KNN MODEL FOR REGRESSION
library(caret)
library(tidyverse)

knn_prediction<-function(datos){
  set.seed(1234)
  
  datos <- datos %>% na.omit()
  
  #Dividimos el conjunto de datos de entrenamiento y testing
  partition <- createDataPartition(datos$price, p = 0.75, list = FALSE)
  #entrenamiento
  training <- datos[partition, ]
  #validación
  testing  <- datos[-partition, ]
  
  trControl_rcv <- trainControl(method  = "repeatedcv", number=10, repeats= 3)
  #rcv(Repeated Cross Validation)
  
  #Quitamos variables de owner y consumption por su poca correlación al precio
  KNN_MODEL <- train(price ~ kms_driven + cilindrada + BHP + model_year, 
                     data = datos, 
                     trControl  = trControl_rcv,
                     method = "knn", 
                     metric     = "Rsquared",
                     tuneGrid = expand.grid(k = 1:20)#probamos diferentes k
                     )
  
  #KNN_MODEL
  
  #KNN_PRED <- predict(KNN_MODEL, newdata = testing )
  
  #KNN_PRED %>% head(10)
  
  #Mostrar medidas
  #evaluacion_knn <- postResample(pred = KNN_PRED, obs = testing$price)
  #evaluacion_knn
  
  #RETURN MEDIA DE ERRORES
  return (KNN_MODEL)
}