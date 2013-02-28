
quijote <- readLines("http://www.gutenberg.org/cache/epub/2000/pg2000.txt", encoding = "UTF-8")

archivo <- file("../data/quijote.txt", "w", encoding="UTF-8")
writeLines(quijote, con = archivo, sep = "\n", useBytes = FALSE)
close(archivo)

str(quijote)
# la obra comienza en la linea 37 y termina en 37490
quijote[1:50]

# tiene 37862 lineas
str(quijote)

?strsplit
str(c(strsplit(quijote[37:50],"[ ,;-]"),recursive=T))


palabras <- c(strsplit(quijote[37:37490],"[[[:punct:][:space:]]"),recursive=T)
palabras[1:100]
str(unlist(palabras))
palabras_ordenadas_x_ocurrencia <- sort(table(palabras),vars=2,decreasing=T)
?order
str(palabras_ordenadas_x_ocurrencia)
str(unlist(palabras_ordenadas_x_ocurrencia))
palabras_ordenadas_x_ocurrencia[1:50]
?array

palabras_ordenadas_x_ocurrencia[1:10][1]
?length
table(palabras_ordenadas_x_ocurrencia[1:50],nchar(names(palabras_ordenadas_x_ocurrencia[1:50])))
table(palabras_ordenadas_x_ocurrencia,nchar(names(palabras_ordenadas_x_ocurrencia)))

# frecuencia de largos:
table(nchar(names(palabras_ordenadas_x_ocurrencia)))
?table

# la mas larga:
names(palabras_ordenadas_x_ocurrencia)[nchar(names(palabras_ordenadas_x_ocurrencia))==21]

?nchar
nchar("123")
?unlist
?scan

quijote[1:50]
quijote2[1:50]
?cbind

# ------------------------------------------------------
# Tomo los datos segun la pista:
  
  quijote <- readLines("http://www.gutenberg.org/cache/epub/2000/pg2000.txt", encoding = "UTF-8")
  quijote <- readLines("../data/pg2000.txt", encoding = "UTF-8")
# La obra comienza en la linea 37 y termina en la 37490

palabras <- c(strsplit(quijote[37:37490],"[[[:punct:][:space:]]"),recursive=T)
palabras_ordenadas_x_ocurrencia <- sort(table(palabras),vars=2,decreasing=T)
#Las primeras 50 mas frecuentes
palabras_ordenadas_x_ocurrencia[1:50]
# Frecuencia segun numero de letras:
  
  table(palabras_ordenadas_x_ocurrencia,nchar(names(palabras_ordenadas_x_ocurrencia)))
cbind(palabras_ordenadas_x_ocurrencia,nchar(names(palabras_ordenadas_x_ocurrencia)))
# la mas larga
names(palabras_ordenadas_x_ocurrencia)[nchar(names(palabras_ordenadas_x_ocurrencia))==21]
# "bienintencionadamente"

aggregate(x = list(frecuencia = palabras_ordenadas_x_ocurrencia), by = list(largo=nchar(names(palabras_ordenadas_x_ocurrencia))) , FUN=sum)

