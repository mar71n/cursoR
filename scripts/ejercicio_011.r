# Un trigrama es una sucesión de tres palabras. Los lingüistas computacionales construyen bases de datos de ellos a partir de textos y los usan para, 
# por ejemplo, crear motores de traducción automáticos.
# 
# En este enlace se ve la evolución temporal del uso de de dos trigramas en los libros que Google tiene escaneados.

# El ejercicio de hoy consiste en la aplicación de las técnicas de procesamiento de texto que hemos aprendido para recolectar trigramas a partir de texto.

# Para eso, a partir de la (muy famosa) frase

frase <- "Y que todo lo escrito en ellos era irrepetible desde siempre y para siempre, porque las estirpes condenadas a cien años de soledad no tenían una segunda oportunidad sobre la tierra."

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

# vamos a ver si somos capaces de construir los trigramas (todos) que contiene. De tener éxito, intentaremos hacer lo mismo con un texto algo más complejo,

frase2 <- "Llegó a la conclusión que aquel hijo por quien ella habría dado la vida era, simplemente, un hombre incapacitado para el amor. Una noche, cuando lo tenía en el vientre, lo oyó llorar. Fue un lamento tan definido, que Jose Arcadio Buendía despertó a su lado y se alegró con la idea de que el niño iba a ser ventrílocuo. Otras personas pronosticaron que sería adivino. Ella, en cambio, se estremeció con la certidumbre de que aquel bramido profundo era un primer indicio de la temible cola de chancho. Pero la lucidez de la decrepitud le permitió ver, y así lo repitió muchas veces, que el llanto de los niños en el vientre de la madre no es augurio de ventriloquía ni facultad adivinatoria, sino una señal inequívoca de incapacidad para el amor."
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


# La complejidad adicional consiste en que los trigramas tienen que circunscribirse a una única frase, no saltan los puntos.
# 
# Finalmente, el premio especial se concederá a quien recopile todos los trigramas del Quijote (frase a frase, sin saltar por encima de los puntos) y nos indique cuáles son los que ocurren más frecuentemente.

quijote <- readLines("../data/pg2000.txt", encoding = "UTF-8")
frase2 <- paste(quijote[37:37490],collapse=" ")
frase2 <- gsub("[,;:-_¿?!¡]", "", frase2)
frase2 <- gsub("[.][ ]", ".", frase2)
oraciones <- strsplit(frase2,"[[:punct:]]")
oraciones.palabras <- strsplit(oraciones[[1]],"[[:space:]]")

a <- matrix(oraciones.palabras[[1]][c(cuales)[1:((length(oraciones.palabras[[1]])-2)*3)]],ncol=3,nrow=length(oraciones.palabras[[1]])-2,byrow=T)
for (i in c(2:length(oraciones.palabras))){
  a <- rbind(a,  matrix(oraciones.palabras[[i]][c(cuales)[1:((length(oraciones.palabras[[i]])-2)*3)]],ncol=3,nrow=length(oraciones.palabras[[i]])-2,byrow=T))
}
