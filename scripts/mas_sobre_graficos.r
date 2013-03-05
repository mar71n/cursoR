# Ejercicio: m�s sobre gr�ficos

# He copiado el siguiente c�digo

N <- 50           # Sample size
set.seed(2)       # establece la semilla del generador de numeros pseudoaleatorios.
x1 <- runif(N)    # Uniform distribution
x2 <- rt(N,2)     # Fat-tailed distribution
x3 <- rexp(N)     # Skewed distribution
x4 <- c(x2,20)    # Outlier (not that uncommon,
# with fat-tailed distributions)
f <- function (x, ...) {
  x <- (x - mean(x)) / sd(x)  # restando la media centro los valores alrededor de cero
                              # dividiendo por la desviacion standar reduzco, mas o menos proporcionalmente, los valores absolutos de cada distribuci�n
  N <- length(x)
  hist( x,
        col = "light blue",
        xlim = c(-3, 3),      # todos los graficos van a estar centrados en cero como efecto de haber restado por la media
        ylim = c(0, .8),      # mostrar solo entre 0 y 0.8, como son probabilidades van a ser menores que 1
        probability = TRUE,   # el histograma no va a representar frecuencias sino probabilidad, resultan de area 1.
        ...                   # parametros graficos que se hayan pasado.
  )
  lines(density(x),            # estimacion de densidad por nucleos, una forma de suavizar y hacer continuo el histograma
        col = "red", lwd = 3)  # linea roja de espesor 3
  rug(x)                      # agrega una marca en el eje x por cada valor.
}
op <- par(mfrow=c(2,2))       # establece la matriz de 2 x 2 donde se van a mostrar los graficos
f(x1, main = "Uniform distribution")
f(x2, main = "Fat-tailed distribution")
f(x3, main = "Skewed distribution")
f(x4, main = "As above, with one outlier")  
par(op)                      # reestablece a las opciones iniciales.
# de esta p�gina. Contiene funciones como rug, density, par, etc.
# 
# El ejercicio consiste en ejecutarlo entendiendo qu� hacen y qu� aporta cada l�nea del c�digo
# (una buena manera de proceder es ejecutarlo tras comentar alguna l�nea y ver qu� pasa).
# 
# Si os quedan dudas, pod�is abrir una pregunta en el foro para que os ayuden vuestros compa�eros.

?par
