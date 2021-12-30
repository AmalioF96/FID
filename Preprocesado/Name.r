eliminarFecha <- function(datos){

    #Eliminamos espacios en blanco sobrantes
    datos$consumption = trimws(firstup(datos$consumption));

    # Metodo que elimina el anio de la columna name
    # Eliminamos la fecha al final del nombre, lo reemplazamos por una cadena vac
    datos$model = stri_replace_last_regex(datos$model,"(\\s(\\d{4}))","");
    
    return(datos);
}

crearColumnaCilindrada <- function(datos){
    # ¿Podemos quitar la cilindrada?
    # Mediante las siguientes instrucciones creamos una nueva columna con la cilindrada
    # y le quitamos el texto cc
    cilindrada = str_extract( datos$model,'(\\d{3})');
    cilindrada = as.data.frame(cilindrada);
    
    #Convertimos la cilindrada a formato numerico
    cilindrada = transform(cilindrada, cilindrada = as.numeric(cilindrada));
    datos <- mutate(datos, cilindrada);

    return(datos);
}

eliminarCilindrada <- function(datos){
    # ¿Podemos quitar la cilindrada?
    # Eliminamos los números sueltos y los que tengan la cadena cc
    datos$model = stri_replace_last_regex(datos$model,"(\\s\\d+cc)","");
    datos$model = stri_replace_last_regex(datos$model,"(\\s\\d{3,})","");

    return(datos);
}
separarModeloYMarca <- function(datos){
    # Creamos una nueva columna donde almacenar la marca
    datos$brand <- gsub("([A-Za-z]+).*", "\\1", datos$model)

    # Dejamos unicamente el modelo en la columna modelo
    datos$model <- gsub("^([A-Za-z]+\\s)", "", datos$model)

    return(datos);
}
preprocesarColumnaName <- function(datos){
    print("Eliminamos la cadena con la fecha.");
    datos = eliminarFecha(datos);
    print("Creamos una nueva columna con la cilindrada");
    datos = crearColumnaCilindrada(datos);
    print("Eliminamos la cilindrada del nombre");
    datos = eliminarCilindrada(datos);
    print("Separamos la marca y el modelo en dos columnas");
    datos = separarModeloYMarca(datos);
    
    return(datos)
}