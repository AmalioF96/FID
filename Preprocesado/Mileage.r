convertirMileageANumerico <- function(datos){
    # Metodo que elimina el texto de la columna y luego la transforma en numerica
    # Ejecutamos el comando dos veces para eliminar el texto del principio y del final de la cadena
    datos$mileage = stri_replace_last_regex(datos$mileage,"(\\D{1,99})","")
    datos$mileage = stri_replace_last_regex(datos$mileage,"(\\D{1,99})","")

    datos$mileage <- as.numeric(datos$mileage)

    return(datos);
}

preprocesarColumnaMileage <- function(datos){
    print("Convertimos la columna a numerica");
    datos = convertirMileageANumerico(datos);

    return(datos)
}