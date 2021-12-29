convertirKmsANumerico <- function(datos){
    # Metodo que elimina el texto de la columna y luego la transforma en numerica
    # Ejecutamos el comando dos veces para eliminar el texto del principio y del final de la cadena
    datos$kms_driven = stri_replace_last_regex(datos$kms_driven,"(\\D{1,99})","");
    datos$kms_driven = stri_replace_last_regex(datos$kms_driven,"(\\D{1,99})","");

    datos$kms_driven <- as.numeric(datos$kms_driven)

    return(datos);             

}

compararConMileage <- function(datos){
    #En el caso de que kms_driven sea = a mileage o = 0 lo sustituimos por NA
    datos$kms_driven <- ifelse(datos$kms_driven %in% datos$consumption, NA, datos$kms_driven)
    datos$kms_driven <- ifelse(datos$kms_driven %in% 0, NA, datos$kms_driven)

    return(datos);
}

preprocesarColumnaKmsDriven <- function(datos){
    print("Convertimos la columna kms_driven a numerica");
    datos = convertirKmsANumerico(datos);
    print("Comparamos la columna kms_driven con la columna Mileage");
    datos = compararConMileage(datos);
    
    return(datos);
}