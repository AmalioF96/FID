convertirConsumptionANumerico <- function(datos){
    # Metodo que elimina el texto de la columna y luego la transforma en numerica
    # Ejecutamos el comando dos veces para eliminar el texto del principio y del final de la cadena
    datos$consumption = stri_replace_last_regex(datos$consumption,"(\\D{1,99})","")
    datos$consumption = stri_replace_last_regex(datos$consumption,"(\\D{1,99})","")

    datos$consumption <- as.double(datos$consumption)

    return(datos);
}

preprocesarColumnaConsumption <- function(datos){
    print("Convertimos la columna a numerica");
    datos = convertirConsumptionANumerico(datos);

    return(datos)
}