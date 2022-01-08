
datos <- read.csv("../Datos/unsupervised_learning_result.csv",header = TRUE, sep=";", dec=",")

boxplot(datos$consumption)
boxplot(datos$cilindrada)
boxplot(datos$kms_driven)
boxplot(datos$BHP)

lowerq = quantile(datos$kms_driven)[2]
upperq = quantile(datos$kms_driven)[4]
iqr = upperq - lowerq #Or use IQR(data)