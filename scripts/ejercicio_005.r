# Vamos a crear una matriz de dimensión 6x10 así:
  
set.seed(1234)
mi.matriz <- matrix(sample(10, size=60, replace=T), 6, 10)

# El problema consiste entonces en:
  
# contar el número de elementos de cada fila mayores que 7 e
# identificar las filas en las que el número 9 aparece exactamente dos veces.

?set.seed
?sample
?rowSums

mi.matriz > 7

mi.matriz[1,]

filas <- dim(mi.matriz)[1]

rowSums(mi.matriz > 7)
matrix(rowSums(mi.matriz > 7),6)
?matrix

rowSums(mi.matriz == 9)
which( rowSums(mi.matriz == 9) == 2)
t(matrix(rowSums(mi.matriz == 9)))
