localizarMotosElectricas <- function(datos){
    # Creamos una nueva columna donde mostramos si la moto es o no electrica
    datos$isElectric <- str_detect(datos$BHP,c("kw","Kw","KW","kW"))
    
    return(datos)
}


firstWord <- function(x) { 
    # Metodo que devuelve la primera palabra de un String
    return(unlist(strsplit(x," "))[1])
}

eliminarMedida <- function(datos){
    # Eliminamos el texto de la columna
    datos$BHP <- sapply(datos$BHP, firstWord)
    datos$BHP = stri_replace_last_regex(datos$BHP,"([a-zA-Z]{1,99})","")
    #datos$BHP = stri_replace_last_regex(datos$BHP,"(kW)","");

    #Convertimos la columna a formato numerico
    datos$BHP <- as.double(datos$BHP)

    return(datos)
}
transformarKWaBPH <- function(datos){
    # Transformamos los valores en Vatios por Horse Power
    datos$BHP <- ifelse(datos$isElectric, datos$BHP * 1.34102, datos$BHP)

    return(datos)
}

preprocesarColumnaBHP <- function(datos){
    print("Creamos la columna isElectric");
    datos = localizarMotosElectricas(datos);
    print("Eliminamos el texto de la columna BHP");
    datos = eliminarMedida(datos);
    print("Transformamos los kW a PH");
    datos = transformarKWaBPH(datos);

    return(datos)
}