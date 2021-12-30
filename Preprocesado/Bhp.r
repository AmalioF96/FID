localizarMotosElectricas <- function(datos){
    datos$isElectric <- str_detect(datos$BHP,c("kw","Kw","KW","kW"))
    return(datos)
}


firstWord <- function(x) {  
    return(unlist(strsplit(x," "))[1])
}

eliminarMedida <- function(datos){
    datos$BHP <- sapply(datos$BHP, firstWord)
    datos$BHP = stri_replace_last_regex(datos$BHP,"(kW)","");
    datos$BHP <- as.double(datos$BHP)

    return(datos)
}
transformarKWaBPH <- function(datos){
    
    datos$BHP <- ifelse(datos$isElectric, datos$BHP * 1.34102, datos$BHP)
    return(datos)
}

preprocesarColumnaBHP <- function(datos){
    print("Creamos la columna isElectric");
    datos = localizarMotosElectricas(datos);
    datos = eliminarMedida(datos);
    datos = transformarKWaBPH(datos);
    return(datos)
}