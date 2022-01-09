#MULTIPLE LINEAR REGRESSION(MLR)
library(tidyverse)
library(caret)

multiple_regresion_prediction<-function(datos){
  
  #Elegimos un método de control de entrenamiento (loocv,k-fold cv, boot, ...)
  trControl_rcv <- trainControl(method  = "repeatedcv",number=10, repeats= 5)
  
  #en nuestro caso será rcv(Repeated Cross Validation)
  
  #escogemos todas las variables para asi tener mayor acierto, ya que todas
  #tienen correlación con el precio final de la motocicleta
  
  MLR_MODEL <- train(price ~ kms_driven + cilindrada + BHP + owner + model_year + consumption, 
                        data = datos,
                        trControl  = trControl_rcv,
                        method = "lm",
                        metric = "Rsquared"
                        )
  return (MLR_MODEL)
}