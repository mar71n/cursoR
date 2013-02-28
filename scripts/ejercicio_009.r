# Hay varias preguntas sobre c�mo ubicar (i.e., encontrar su posici�n en el vector) el m�ximo valor de un vector. 
# (De hecho, es una operaci�n tan com�n que en R existe la funci�n which.max, equivalente a which(x == max(x))).

# Ahora bien, �c�mo encontrar�amos la posici�n del segundo valor m�s peque�o de un vector? Por fijar ideas, sea dicho vector el siguiente:
  
  mi.vector <- rnorm(1000)
# �Qu� expresi�n que devuelva el �ndice de la observaci�n que buscamos? �Lo podemos hacer en una �nica l�nea?
  
  ?vector
  max(mi.vector)
  min(mi.vector)
  mi.vector[1:10]
  order(mi.vector[1:10])
  mi.vector[order(mi.vector[1:10])][2]
  mi.vector[order(mi.vector)][2]
  