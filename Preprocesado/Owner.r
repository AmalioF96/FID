convertirOwnerANumerico <- function(datos){
    # Convertimos el texto a matusculas para que sea mas sencillo tratarlo
    datos$owner = toupper(datos$owner);

    # Cambiamos el valor ordinal por el cardinal
    datos$owner = stri_replace_last_regex(datos$owner,"(FIRST)","1");
    datos$owner = stri_replace_last_regex(datos$owner,"(SECOND)","2");
    datos$owner = stri_replace_last_regex(datos$owner,"(THIRD)","3");
    datos$owner = stri_replace_last_regex(datos$owner,"(FOURTH)","4");

    # Eliminamos textos innecesarios
    datos$owner = stri_replace_last_regex(datos$owner,"(\\D{1,99})","")
    datos$owner = stri_replace_last_regex(datos$owner,"(\\D{1,99})","")

    # Convertimos la columna a formato numérico
    datos$owner <- as.numeric(datos$owner)

    return(datos);             

}

preprocesarColumnaOwner <- function(datos){
    print("Convertimos la columna Owner a numerica");
    datos = convertirOwnerANumerico(datos);
    
    return(datos);
}