
firstup <- function(x) {
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  return(x);
}

cambiarLetraCapital <- function(datos){
    datos$location = trimws(firstup(datos$location));
    
    return(datos);
}

preprocesarColumnaLocation <- function(datos){
    print("Pasamos la primera letra a Mayus");
    datos = cambiarLetraCapital(datos);
    
    return(datos)
}