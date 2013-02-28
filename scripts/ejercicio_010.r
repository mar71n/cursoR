# Una de las funciones m�s �ltiles que existen para trabajar con texto es paste. Permite concatenar cadenas de texto.
?paste
# El ejercicio que se pide resolver esta vez es, a partir del vector

letters
# (que existe en R y muestra las letras del alfabeto ingl�s) crear:
  
# El vector (de longitud 4) "a--1" "b--2" "c--3" "d--4"

paste(letters[1:4],c(1:4),sep="--")

# La cadena "a--1$b--2$c--3$d--4"

paste(letters[1:4],c(1:4),sep="--",collapse="$")
