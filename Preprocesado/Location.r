
firstup <- function(x) {
  # Esta funcion pasa a mayuscula la primera letra de la primera palabra
  # de un string introducido por parametros
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  return(x);
}

cambiarLetraCapital <- function(datos){
    # Ponemos la primera letra del String en mayusculas
    datos$location = trimws(firstup(datos$location));
    
    return(datos);
}

preprocesarColumnaLocation <- function(datos){
    print("Pasamos la primera letra a Mayus");
    datos = cambiarLetraCapital(datos);
    
    return(datos)
}