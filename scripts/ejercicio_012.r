# Vamos a crear primero tres vectores de datos con distribuciones dispares:
  
  discreta <- sample(1:10, 100, prob=seq(from=0.1,to=1.0, length.out=10), replace=TRUE)
  exponencial <- rexp(1000)
  bimodal <- c(rnorm(1000), rnorm(1000, mean=5, sd=2))
  
  
# El ejercicio consiste en crear gráficos para los tres vectores (incluyendo diagramas de cajas, 
# el histograma y la densidad) para comprobar qué aspecto tienen. 
# ¿Son igualmente útiles para los tres tipos de datos? ¿Qué gráfico refleja mejor cada vector/distribución?
  
#   hola. histograma , cajas -bigote dan bastante información. En el caso exponencial se ve mejor en histograma
  
  layout(matrix(c(1,2,3,4),2,2,byrow=TRUE))
  
  boxplot(discreta,main="Discreta")
  
  boxplot(exponencial,main="exponencial")
  
  boxplot(bimodal,main="bimodal")
  
  boxplot(discreta,exponencial,bimodal,main="caja y bigotes",xlab="disc,expo,bimo",ylab="frecuencia")
  
  hist(discreta,main="discreta",xlab="datos")
  
  hist(exponencial,main="exponencial",xlab="datos")
  
  hist(bimodal,main="bimodal",xlab="datos")
  
  
  # plot(x, y, ... veo que es mejor para reprecentar una variable en funcion de otra, no distribuciones
  
  
