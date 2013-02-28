# vamos a ver si somos capaces de construir los trigramas (todos) que contiene. De tener �xito, intentaremos hacer lo mismo con un texto algo m�s complejo,

# intento resolver el problema atendiendo la mantra de la pagina 36 de icebreakeR
# The R programming mantra might be: 
# compile only if you need to, loop only if you have to, and vectorize all the time.
# Compila solo cuando sea necesario, itera solo cuando tengas que hacerlo, y vectoriza siempre.

# La idea es que los trigramas son las palabras 1, 2, 3, 2, 3, 4, 3, 4, 5 ... de una oracion
# Construyo la secuencia:

f <- function(x){
  append(x,c(x[length(x)-1],x[length(x)-1]+1,x[length(x)-1]+2))
}

cuales <- c(1,2,3)
for(i in 1:97) cuales <- f(cuales)

frase2 <- "Lleg� a la conclusi�n que aquel hijo por quien ella habr�a dado la vida era, simplemente, un hombre incapacitado para el amor. Una noche, cuando lo ten�a en el vientre, lo oy� llorar. Fue un lamento tan definido, que Jose Arcadio Buend�a despert� a su lado y se alegr� con la idea de que el ni�o iba a ser ventr�locuo. Otras personas pronosticaron que ser�a adivino. Ella, en cambio, se estremeci� con la certidumbre de que aquel bramido profundo era un primer indicio de la temible cola de chancho. Pero la lucidez de la decrepitud le permiti� ver, y as� lo repiti� muchas veces, que el llanto de los ni�os en el vientre de la madre no es augurio de ventriloqu�a ni facultad adivinatoria, sino una se�al inequ�voca de incapacidad para el amor."

# limpio un poco
frase2 <- gsub(",", "", frase2)
frase2 <- gsub("[.][ ]", ".", frase2)

# Las oraciones, cortando en los puntos. Y sus palabras.
oraciones <- strsplit(frase2,"[[:punct:]]")
oraciones.palabras <- strsplit(oraciones[[1]],"[[:space:]]")

# Dado un arreglo de palabras (oracion) devuelve los trigramas.
tris_ <- function(palabras){
  largo <- length(palabras)
  matrix(palabras[c(cuales)[1:((largo-2)*3)]],ncol=3,nrow=largo-2,byrow=T)
}

# Obtengo los trigramas
v_trigramas <- lapply(oraciones.palabras, tris_)

