# Una de las funciones más últiles que existen para trabajar con texto es paste. Permite concatenar cadenas de texto.
?paste
# El ejercicio que se pide resolver esta vez es, a partir del vector

letters
# (que existe en R y muestra las letras del alfabeto inglés) crear:
  
# El vector (de longitud 4) "a--1" "b--2" "c--3" "d--4"

paste(letters[1:4],c(1:4),sep="--")

# La cadena "a--1$b--2$c--3$d--4"

paste(letters[1:4],c(1:4),sep="--",collapse="$")
