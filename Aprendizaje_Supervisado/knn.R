#KNN MODEL FOR REGRESSION
library(caret)
library(tidyverse)

knn_prediction<-function(datos){

  trControl_rcv <- trainControl(method = "repeatedcv", number=10, repeats= 5)
  #rcv(Repeated Cross Validation)
  
  #Quitamos variables de owner y consumption por su poca correlación al precio
  KNN_MODEL <- train(price ~ kms_driven + cilindrada + BHP  + owner + model_year + consumption, 
                     data = datos, 
                     trControl  = trControl_rcv,
                     method = "knn",
                     tuneGrid = expand.grid(k = 1:20)#probamos diferentes k
                     )

  return (KNN_MODEL)
}