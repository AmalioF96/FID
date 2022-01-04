tratarNaValues <- function(datos){
    
    # Vemos que hay columnas que tienen NA, los corregimos
    sapply(datos, function(x) sum(is.na(x)))
    #Cambiamos los ceros de la columna precio por NA y volvemos a visualizar los datos
    datos$price[datos$price == 0] <- NA
    print(sapply(datos, function(x) sum(is.na(x))))
    
    # Mediante KNN reemplazamos los NA por nuevos valores
    kNN(datos,variable=c("kms_driven","consumption","BHP","price","cilindrada"),k=5)
    print(sapply(datos, function(x) sum(is.na(x))))
}