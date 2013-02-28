# Hay varias preguntas sobre cómo ubicar (i.e., encontrar su posición en el vector) el máximo valor de un vector. 
# (De hecho, es una operación tan común que en R existe la función which.max, equivalente a which(x == max(x))).

# Ahora bien, ¿cómo encontraríamos la posición del segundo valor más pequeño de un vector? Por fijar ideas, sea dicho vector el siguiente:
  
  mi.vector <- rnorm(1000)
# ¿Qué expresión que devuelva el índice de la observación que buscamos? ¿Lo podemos hacer en una única línea?
  
  ?vector
  max(mi.vector)
  min(mi.vector)
  mi.vector[1:10]
  order(mi.vector[1:10])
  mi.vector[order(mi.vector[1:10])][2]
  mi.vector[order(mi.vector)][2]
  