# Cargo estos dos archivos de datos:
  
t_indultos <- read.csv("../data/indultos.csv")
t_indultos_cat <- read.csv("../data/indultos_cat_crimen.csv")

table(t_indultos$pardon_year)
# 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 
# 47  530  738 1582  741 1744  245  253  299  320  457  517  543  442  438  404  359  534   12
hist(t_indultos$pardon_year)

# Me pregunto que paso en 1998 y 2000
table(t_indultos_cat$crime_cat,t_indultos_cat$pardon_year)
# mirando los datos veo que en esos años se destacan dos categorias de delito indultados

table(t_indultos_cat[grep("servicio militar",t_indultos_cat$crime),]$pardon_year)
# 1996 1997 1998 2000 
# 7    1  682  352     
table(t_indultos_cat[grep("delito contra la seguridad del tr.+fico",t_indultos_cat$crime),]$pardon_year)
# 1996 1997 1998 1999 2000 2001 2002 2003 2004 2008 2010 2012 2013 
# 10   23   21    4  219   27   16   25   10    1    1    4    1
# Lo de la mili explica bastante bien lo del '98 , en el 2000 se le agrega lo de seguridad en el tráfico.
# 
# Entiendo lo de la mili. En el 2001 Aznar la termino, pero parece que ese fin ya era un hecho unos años antes (suele pasar).
# 
# Lo de seguridad en el tráfico, no se.




# ##################################### con graficos #############################

# Cargo estos dos archivos de datos:

t_indultos <- read.csv("../data/indultos.csv")

str(t_indultos)

# no hay pardon_year NA
table(t_indultos$pardon_year,useNA=c("ifany"))
# 275 casos con inicio NA
table(t_indultos$crime_initial_year,useNA=c("ifany"))
# hat 7 magistrados en los que todos los inicios son NA
table(t_indultos$crime_initial_year,t_indultos$signature,useNA=c("ifany"))
table(t_indultos[is.na(t_indultos$crime_initial_year),]$signature)
table(t_indultos$signature)
# son los 7 donde coinciden Tot_inicio_NA y Tot_indultos (es decir, todos los indultos tiene inicio NA)
cbind(Tot_inicio_NA=table(t_indultos[is.na(t_indultos$crime_initial_year),]$signature),
      Tot_indultos=table(t_indultos$signature)
)
# los excluyo, ya que de estos no puedo calcular la "espera"
t_indultos_a <- t_indultos[!is.na(t_indultos$crime_initial_year),]
# 10205 - 9930 = 275

t_indultos_a$espera <- t_indultos_a$pardon_year - t_indultos_a$crime_initial_year
layout(matrix(c(1:2),2,1))
barplot(table(t_indultos_a$espera),main="Frecuencia de espera")

signature_promedio_espera <- aggregate(x= list(t_indultos_a$espera), by=list(t_indultos_a$signature), FUN = mean, na.rm=T)
names(signature_promedio_espera) <- c("juez", "Promedio de espera")

# layout(matrix(c(2,1),1,2))
# layout(matrix(c(2,1),2,1))
barplot(signature_promedio_espera$"Promedio de espera",main="Promedio de espera por signature")
# boxplot(signature_promedio_espera$"Promedio de espera")

layout(matrix(1:9,3,3))
aggregate(x= list(t_indultos_a$espera), by=list(t_indultos_a$signature), FUN = boxplot, na.rm=T,ylim=c(0,20))

