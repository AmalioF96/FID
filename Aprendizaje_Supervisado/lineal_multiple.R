#MULTIPLE LINEAR REGRESSION(MLR)
library(tidyverse)
library(caret)

multiple_regresion_prediction<-function(datos){
  #semilla para reproducibilidad
  set.seed(1234)
  
  #Dividimos el conjunto de datos de entrenamiento y testing
  partition <- createDataPartition(datos$price, p = 0.75, list = FALSE)
  
  #entrenamiento
  training <- datos[partition, ]
  
  #validación
  testing  <- datos[-partition, ]
  
  #Elegimos un método de control de entrenamiento (loocv,k-fold cv, boot, ...)
  trControl_rcv <- trainControl(method  = "repeatedcv",number=10, repeats= 5)
  
  #en nuestro caso será rcv(Repeated Cross Validation)
  
  #escogemos todas las variables excepto owner y consumption, las cuales
  #tienen una correlación ínfima con el precio
  MLR_MODEL <- train(price ~ kms_driven + cilindrada + BHP + model_year, 
                        data = datos,
                        trControl  = trControl_rcv,
                        method = "lm", 
                        metric = "Rsquared"
                        )
  
  #MLR_MODEL
  
  #MLR_PRED <- predict(MLR_MODEL, newdata = testing)
  
  #MLR_PRED %>% head(10)
  
  #Mostrar medidas
  #evaluacion_lm <- postResample(pred = MLR_PRED, obs = testing$price)
  #evaluacion_lm

  return (MLR_MODEL)
}