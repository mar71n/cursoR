require(lattice)
require(ggplot2)

# Definicion de una variable con los tipos de erupcion
faithful$tipo <- factor(ifelse(faithful$eruptions < 3.2,"corto","largo"))

# Figura con los diagramas de caja
fig <- ggplot(faithful, aes(tipo, waiting, fill=tipo))
fig  + geom_boxplot(notch=T)

# Figura con las funciones de densidad
fig <- ggplot(faithful, aes(x = waiting))
fig + geom_density(aes(fill=tipo), alpha=0.4, size=0.5)
# Observaci�n: si se pone "alpha" dentro de "aes", aparecer� una segunda leyenda. Otra opci�n alternativa para quitarla ser�a utilizar lo siguiente:
  
fig <- fig + geom_density(aes(fill=tipo, alpha=0.2), size=0.5)
fig
fig + scale_alpha(guide = 'none')