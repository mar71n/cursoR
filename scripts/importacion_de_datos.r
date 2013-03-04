# Ejercicio: importación de datos

datos_treemap <- read.delim("../data/datos_treemap.txt")


datos_treemap <- read.delim("http://datanalytics.com/uploads/datos_treemap.txt")

str(datos_treemap)
# 'data.frame':  34 obs. of  3 variables:
# $ valor: Factor w/ 34 levels "ABE","ABG","ACS",..: 1 2 3 4 5 6 7 8 9 10 ...
# $ cap  : int  7793 1473 7930 2217 5910 3760 24819 1646 1589 11644 ...
# $ div  : num  12.04 1.23 8.13 5.06 2.27 ...