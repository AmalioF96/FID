eliminarCeros <- function(datos){
    datos_aux=NULL
    for( i in 1:nrow(datos)){
        if(datos$price[i]!=0){
            datos_aux <- rbind(datos_aux,datos[i,])
        }
    }
    datos=datos_aux
    return(datos)
}


preprocesarColumnaPrice <- function(datos){
    print("Eliminamos las filas con valor cero en precio");
    datos = eliminarCeros(datos);

    return(datos)
}