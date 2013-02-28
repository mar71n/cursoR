# Este es un ejercicio acerca de cómo crear con R ciertos vectores con un patrón determinado. Por ejemplo,

1:10
# crea el vector (1, 2, 3,... 10).

# Están ordenados de fácil a difícil.

# 1.(11, 12, 13,... , 19, 20)
11:20

# 2.(20, 19,... , 2, 1)
20:1

# 3.(1, 2, 3,... , 19, 20, 19, 18,... , 2, 1)
c(1:20,19:1)

# 4.(4, 6, 3, 4, 6, 3,... , 4, 6, 3) donde el 4 aparece 10 veces.
?rep
rep(c(4,6,3),10)

# 5.(4, 6, 3, 4, 6, 3,... , 4, 6, 3, 4) donde el 4 aparece 11 veces y 6 y 3 aparecen 10 veces.
rep(c(4,6,3),11,length.out=31)
rep(c(4,6,3),11)[1:31]
rep(c(4,6,3),11,l=31)

str(rep(c(1,2,3),11,l=31))
x <- rep(c(1,2,3),11,l=31) 
x[length(x)]
cuales

f <- function(x){
  append(x,c(x[length(x)-1],x[length(x)-1]+1,x[length(x)-1]+2))
}

f(f(f(f(f(f(f(f(f(c(1,2,3))))))))))

# 6.(4, 4,... , 4, 6, 6,... , 6, 3, 3,... , 3) donde 4 aparece 10 veces; 6, 20 veces y 3, 30 veces.
rep(c(4,6,3),c(10,20,30))
rep(c(4,6,3),1:3*10)

# Pista: para los ejercicios 4, 5 y 6, consultar ?rep.