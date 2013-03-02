# Cargo estos dos archivos de datos:
  
t_indultos <- read.csv("../data/indultos.csv")
t_indultos_cat <- read.csv("../data/indultos_cat_crimen.csv")

table(t_indultos$pardon_year)
# 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 
# 47  530  738 1582  741 1744  245  253  299  320  457  517  543  442  438  404  359  534   12

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

x <- table(t_indultos$pardon_year - t_indultos$crime_initial_year , t_indultos$signature)
plot(melt(table(t_indultos$pardon_year - t_indultos$crime_initial_year , t_indultos$signature)))

t_indultos$espera <- t_indultos$pardon_year - t_indultos$crime_initial_year

t_i_m <- melt(t_indultos, id=c("signature"), measures=c("espera"))

str(x)
hist(x)
plot(x)
tapply(,)

x[1]

subset(t_indultos,select=c("signature","espera"))
plot(subset(t_indultos,select=c("signature","espera")))

as.data.frame(table(t_indultos$signature,t_indultos$espera))
?table