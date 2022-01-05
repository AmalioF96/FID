convertirConsumptionANumerico <- function(datos){
    # Metodo que elimina el texto de la columna y luego la transforma en numerica
    # Ejecutamos el comando dos veces para eliminar el texto del principio y del final de la cadena

    datos$consumption = trimws(firstup(datos$consumption));

    datos$consumption = stri_replace_last_regex(datos$consumption,"(-[0-9]{1,2})","")
    datos$consumption = stri_replace_last_regex(datos$consumption,"([a-zA-Z]{1,99})","")
    datos$consumption = stri_replace_last_regex(datos$consumption," ","")

    datos$consumption <- as.double(datos$consumption)

    return(datos);
}

preprocesarColumnaConsumption <- function(datos){
    print("Convertimos la columna a numerica");
    datos = convertirConsumptionANumerico(datos);

    return(datos)
}