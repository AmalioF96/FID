eliminarFecha <- function(datos){
    # Metodo que elimina el anio de la columna name
    # Eliminamos la fecha al final del nombre, lo reemplazamos por una cadena vac
    datos$model_name = stri_replace_last_regex(datos$model_name,"(\\s(\\d{4}))","");
    return(datos);
}

crearColumnaCilindrada <- function(datos){
    # ¿Podemos quitar la cilindrada?
    # Mediante las siguientes instrucciones creamos una nueva columna con la cilindrada
    # y le quitamos el texto cc
    cilindrada = str_extract( datos$model_name,'(\\d{3})');
    cilindrada = as.data.frame(cilindrada);
    #cilindrada[is.na(cilindrada)] <- 0;
    cilindrada = transform(cilindrada, cilindrada = as.numeric(cilindrada));
    datos <- mutate(datos, cilindrada);
    return(datos);
}

eliminarCilindrada <- function(datos){
    # ¿Podemos quitar la cilindrada?
    # Eliminamos los números sueltos y los que tengan la cadena cc
    
    datos$model_name = stri_replace_last_regex(datos$model_name,"(\\s\\d+cc)","");
    datos$model_name = stri_replace_last_regex(datos$model_name,"(\\d{3})","");
    return(datos);
}

preprocesarColumnaName <- function(datos){
    print("Eliminamos la cadena con la fecha.");
    datos = eliminarFecha(datos);
    print("Creamos una nueva columna con la cilindrada");
    datos = crearColumnaCilindrada(datos);
    print("Eliminamos la cilindrada del nombre");
    datos = eliminarCilindrada(datos);
    
    return(datos)
}