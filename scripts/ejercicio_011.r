# Un trigrama es una sucesi�n de tres palabras. Los ling�istas computacionales construyen bases de datos de ellos a partir de textos y los usan para, 
# por ejemplo, crear motores de traducci�n autom�ticos.
# 
# En este enlace se ve la evoluci�n temporal del uso de de dos trigramas en los libros que Google tiene escaneados.

# El ejercicio de hoy consiste en la aplicaci�n de las t�cnicas de procesamiento de texto que hemos aprendido para recolectar trigramas a partir de texto.

# Para eso, a partir de la (muy famosa) frase

frase <- "Y que todo lo escrito en ellos era irrepetible desde siempre y para siempre, porque las estirpes condenadas a cien a�os de soledad no ten�an una segunda oportunidad sobre la tierra."

oraciones <- strsplit(frase,"[[:punct:]]")
oraciones.palabras <- strsplit(oraciones[[1]],"[[:space:]]")

vector.pos <- function(k){
  retval <- c(1:3)
  while(max(retval) < k){
    largo <- length(retval)
    retval <- c(retval,retval[(largo-2):largo] + c(1,1,1))
  }
  return(retval)
}

vector.pos <- function(k){
  retval <- c(1:3)
  largo <- 3
  for(i in c(1:(k-3))){
    retval <- c(retval,retval[(largo-2):largo] + c(1,1,1))
    largo <- largo + 3
  }
  return(retval)
}

f <- function(x){
  append(x,c(x[length(x)-1],x[length(x)-1]+1,x[length(x)-1]+2))
}

x <- c(1,2,3)
for(i in 1:97) x <- f(x)

# cuales <- vector.pos(100)
cuales <- x

tri_1 <- matrix(oraciones.palabras[[1]][c(cuales)[1:((length(oraciones.palabras[[1]])-2)*3)]],ncol=3,nrow=length(oraciones.palabras[[1]])-2,byrow=T)
tri_2 <- matrix(oraciones.palabras[[2]][c(cuales)[1:((length(oraciones.palabras[[2]])-2)*3)]],ncol=3,nrow=length(oraciones.palabras[[2]])-2,byrow=T)

tris <- function(palabras,i){
  largo <- length(palabras[[i]])
  matrix(palabras[[i]][c(cuales)[1:((largo-2)*3)]],ncol=3,nrow=largo-2,byrow=T)
}

tris_ <- function(palabras){
  largo <- length(palabras)
  matrix(palabras[c(cuales)[1:((largo-2)*3)]],ncol=3,nrow=largo-2,byrow=T)
}

tri_1 <- tris(oraciones.palabras,1)

tri_1 <- tris_(oraciones.palabras[[1]])



tri.b <- tris(oraciones.palabras,1)
for (i in c(2:length(oraciones.palabras))){
  tri.b <- rbind(tri.b, tris(oraciones.palabras,i ))
}

tris(oraciones.palabras,c(1,2))
oraciones.palabras[[1]]

lapply(oraciones.palabras, tris_)


tri.a <- matrix(oraciones.palabras[[1]][c(cuales)[1:((length(oraciones.palabras[[1]])-2)*3)]] , ncol=3 , nrow=length(oraciones.palabras[[1]])-2 , byrow=T)
for (i in c(2:length(oraciones.palabras))){
  tri.a <- rbind(tri.a,  matrix(oraciones.palabras[[i]][c(cuales)[1:((length(oraciones.palabras[[i]])-2)*3)]],ncol=3,nrow=length(oraciones.palabras[[i]])-2,byrow=T))
}

# vamos a ver si somos capaces de construir los trigramas (todos) que contiene. De tener �xito, intentaremos hacer lo mismo con un texto algo m�s complejo,

frase2 <- "Lleg� a la conclusi�n que aquel hijo por quien ella habr�a dado la vida era, simplemente, un hombre incapacitado para el amor. Una noche, cuando lo ten�a en el vientre, lo oy� llorar. Fue un lamento tan definido, que Jose Arcadio Buend�a despert� a su lado y se alegr� con la idea de que el ni�o iba a ser ventr�locuo. Otras personas pronosticaron que ser�a adivino. Ella, en cambio, se estremeci� con la certidumbre de que aquel bramido profundo era un primer indicio de la temible cola de chancho. Pero la lucidez de la decrepitud le permiti� ver, y as� lo repiti� muchas veces, que el llanto de los ni�os en el vientre de la madre no es augurio de ventriloqu�a ni facultad adivinatoria, sino una se�al inequ�voca de incapacidad para el amor."
strsplit(frase2,"[[:punct:]]")

frase2 <- gsub(",", "", frase2)
frase2 <- gsub("[.][ ]", ".", frase2)

oraciones <- strsplit(frase2,"[[:punct:]]")
str(oraciones)
oraciones.palabras <- strsplit(oraciones[[1]],"[[:space:]]")
str(oraciones.palabras)

tri.b <- matrix(oraciones.palabras[[1]][c(cuales)[1:((length(oraciones.palabras[[1]])-2)*3)]],ncol=3,nrow=length(oraciones.palabras[[1]])-2,byrow=T)
for (i in c(2:length(oraciones.palabras))){
  tri.b <- rbind(tri.b,  matrix(oraciones.palabras[[i]][c(cuales)[1:((length(oraciones.palabras[[i]])-2)*3)]],ncol=3,nrow=length(oraciones.palabras[[i]])-2,byrow=T))
}


# La complejidad adicional consiste en que los trigramas tienen que circunscribirse a una �nica frase, no saltan los puntos.
# 
# Finalmente, el premio especial se conceder� a quien recopile todos los trigramas del Quijote (frase a frase, sin saltar por encima de los puntos) y nos indique cu�les son los que ocurren m�s frecuentemente.

quijote <- readLines("../data/pg2000.txt", encoding = "UTF-8")
frase2 <- paste(quijote[37:37490],collapse=" ")
frase2 <- gsub("[,;:-_�?!�]", "", frase2)
frase2 <- gsub("[.][ ]", ".", frase2)
oraciones <- strsplit(frase2,"[[:punct:]]")
oraciones.palabras <- strsplit(oraciones[[1]],"[[:space:]]")

a <- matrix(oraciones.palabras[[1]][c(cuales)[1:((length(oraciones.palabras[[1]])-2)*3)]],ncol=3,nrow=length(oraciones.palabras[[1]])-2,byrow=T)
for (i in c(2:length(oraciones.palabras))){
  a <- rbind(a,  matrix(oraciones.palabras[[i]][c(cuales)[1:((length(oraciones.palabras[[i]])-2)*3)]],ncol=3,nrow=length(oraciones.palabras[[i]])-2,byrow=T))
}
