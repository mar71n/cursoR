
# Crea un vector lógico
x <- seq(-3,3,length=200) > 0
?seq
-3-(-3-3)/199

# ¿Cómo puedes negarlo (es decir, intercambiar TRUE y FALSE)?
x <- !x

# Calcula la tabla de verdad del operador AND así
c(T,T,F,F) & c(T,F,F,T)
# y construye la tabla análoga para el operador OR. ¿Te atreves con el operador XOR?
# busco en:
??logical
library(help="base")
?Logic
c(T,T,F,F) | c(T,F,F,T)
xor(c(T,T,F,F), c(T,F,F,T))

# mas elegante, en ?Logic, Logical Operators
## construct truth tables :
x <- c(NA, FALSE, TRUE)
names(x) <- as.character(x)
outer(x, x, "&")## AND table
outer(x, x, "|")## OR  table
outer(x, x, "xor")## XOR  table

# ¿Qué pasa al hacer 1:3 + c(T,F,T)? ¿Por qué? 
# [1] 2 2 4
# Hace 1 + T, 2 + F, 3 + T = 1 +1, 2 + 0, 3 + 1 = 2, 2, 4
# segun:
# ?T
# Logical vectors are coerced to integer vectors in contexts where a numerical value is required, 
# with TRUE being mapped to 1L, FALSE to 0L and NA to NA_integer_.


# Calcula la intersección de (1, 2,..., 10} y {5, 6,..., 15} así:
  
intersect(1:10,5:15)

# ¿Puedes también calcular la diferencia entre ambos conjuntos?
# En teoría de conjuntos, la diferencia entre dos conjuntos es una operación que resulta en otro conjunto, 
# cuyos elementos son todos aquellos en el primero de los conjuntos iniciales que no estén en el segundo. 
# Por ejemplo, la diferencia entre el conjunto de los números naturales N y el conjunto de los números pares P 
# es el conjunto de los números que no son pares, es decir, los impares I:
?intersect
setdiff(1:10,5:15) # A \ B
setdiff(5:15,1:10) # B \ A

setdiff(union(1:10,5:15),intersect(1:10,5:15)) # diferencia simétrica
c(setdiff(1:10,5:15),setdiff(5:15,1:10))

# mas general:
diferencia <- function(x1, x2)
{
  c(setdiff(x1, x2),setdiff(x2, x1))
}

diferencia(1:10,5:15)


