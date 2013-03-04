# Ejercicio: más sobre gráficos

# He copiado el siguiente código

N <- 50           # Sample size
set.seed(2)
x1 <- runif(N)    # Uniform distribution
x2 <- rt(N,2)     # Fat-tailed distribution
x3 <- rexp(N)     # Skewed distribution
x4 <- c(x2,20)    # Outlier (not that uncommon,
# with fat-tailed distributions)
f <- function (x, ...) {
  x <- (x - mean(x)) / sd(x)
  N <- length(x)
  hist( x,
        col = "light blue",
        xlim = c(-3, 3),
        ylim = c(0, .8),
        probability = TRUE,
        ...
  )
  lines(density(x), 
        col = "red", lwd = 3)
  rug(x)
}
op <- par(mfrow=c(2,2))
f(x1, main = "Uniform distribution")
f(x2, main = "Fat-tailed distribution")
f(x3, main = "Skewed distribution")
f(x4, main = "As above, with one outlier")  
par(op)
# de esta página. Contiene funciones como rug, density, par, etc.
# 
# El ejercicio consiste en ejecutarlo entendiendo qué hacen y qué aporta cada línea del código
# (una buena manera de proceder es ejecutarlo tras comentar alguna línea y ver qué pasa).
# 
# Si os quedan dudas, podéis abrir una pregunta en el foro para que os ayuden vuestros compañeros.
