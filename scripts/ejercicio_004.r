# Construyo la lista

x <- list(a=1, b=2, c=3, d=4)
# ¿De qué manera puedo acceder al valor del segundo elemento (correspondiente a b)?
x[[2]]
x$b
# ¿Qué diferencia existe entre x[3] y x[[3]]?
?list

x
str(x)

x[3]          # es el par nombre - valor, donde nombre puede estar vacio (en cuyo caso se accede al valor solo por su indice)
str(x[3])     # es una lista (un objeto de la clase list) con un único elemento: el objeto almacenado.
class(x[3])   # list

x[[3]]        # es el valor, el objeto almacenado.
x$c
str(x[[3]])   # es el objeto almacenado, de la clase que corresponda, en este caso numeric
class(x[[3]]) # numeric

x1 <- list(a=1, b=2, c=c(3,5), d=4)
x1
str(x1)

x1[3]      # es el par nombre - valor 
str(x1[3])

x1[[3]]    # es el valor
str(x1[[3]])

list(1)
str(list(1)[1])
list(1)[[1]]
list(a=1)$a
str(list(1))
str(list(a=1))

pairlist(a=1)
pairlist(1)[[1]]


