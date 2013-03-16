# En los cursos de R (y este no es la excepción) se comienza por los elementos de la representación gráfica de datos. 
# Por ejemplo, en el capítulo 8 de icebreakeR se estudia el conjunto de datos ufc utilizando (sobre todo al principio) 
# funciones bastante básicas y primarias.
# 
# Sin embargo, la comunidad de usuarios de R ha creado herramientas más sofisticadas para realizar análisis gráficos. 
# Una de ellas es el paquete GGally que describí hace un tiempo en mi bitácora.
# 
# El ejercicio consiste en analizar ufc (como en icebreakeR) usando dicho paquete. 
# Pero, ¡cuidado! No se puede aplicar directamente: hay cosas que corregir en los datos, opciones que utilizar para mejorar el resultado final, etc.
# 
# ¿Sois capaces de crear un resumen gráfico interesante de los datos?

# Chapter 8
# Graphics
# One major selling point for R is that it has better graphics-producing capabilities than many of the
# commercial alternatives. Whether you want quick graphs that help you understand the structure of your
# data, or publication-quality graphics that accurately communicate your message to your readers, R will
# suce1.
# The graphics are controlled by scripts, and start at a very simple level. If you have dbh.cm and
# height.m in your ufc dataframe2, for example

ufc <- read.csv("../data/ufc.csv")
ufc$height.m <- ufc$height/10
ufc$dbh.cm <- ufc$dbh/10
table(ufc$height.m) # hay un 0.0
ufc$height.m[ufc$height.m < 0.1] <- NA
ufc$species[ufc$species %in% c("F","FG")] <- "GF"
ufc$species <- factor(ufc$species)
ufc.baf <- 7
cm.to.inches <- 1/2.54
m.to.feet <- 3.281
bd.ft.to.m3 <- 0.002359737
ufc$g.ma2 <- ufc$dbh.cm^2*pi/40000
ufc$tree.factor <- ufc.baf / ufc$g.ma2
ufc$tree.factor[is.na(ufc$dbh.cm)] <- 0

plot(ufc$dbh.cm, ufc$height.m)

# will open a graphical window and draw a scatterplot of dbh against height for the Upper Flat Creek
# data, labeling the axes appropriately. A small addition will provide more informative labels (see Figure
# 8.1). Also note that there is more than one way of calling a plot, sometimes the following construction
# may be more convenient.

plot(height.m ~ dbh.cm, data=ufc, xlab = "Diameter (cm)", ylab = "Height (m)")

# The plot() command oers a wide variety of options for customizing the graphic. Each of the
# following arguments can be used within the plot() statement, singly or together, separated by commas.
# That is, the plot statement will look like
# > plot(x, y, xlab="An axis label", ... )
# . xlim=c(a,b) will set the lower and upper limits of the x-axis to be a and b respectively. Note that
# we have to know a and b to make this work!
# . ylim=c(a,b) will set the lower and upper limits of the y-axis to be a and b respectively. Note that
# we have to know a and b to make this work!
# . xlab="X axis label goes in here"
# . ylab="Y axis label goes in here"
# . main="Plot title goes in here"
# . col="red" makes all the points red. This is specially attractive for overlaid plots.

# ggplot_graficos_calidad.pdf pg.7 
# Al emplear este paquete es posible utilizar dos funciones: qplot y ggplot. La
# principal diferencia entre estas dos funciones es que con la segunda se pueden
# presentar diferentes datos y gracos en un mismo plano cartesiano; mientra que
# con la primera solo se puede generar un graco por plano cartesiano. En la Fi-

library(ggplot2)

qplot(height.m , dbh.cm, data=ufc, xlab = "Diameter (cm)", ylab = "Height (m)")

# 8.1 Organization Parameters
# From here we have great 
# exibility in terms of symbol choice, color, size, axis labeling, over-laying, etc.
# We'll showcase a few of the graphical capabilities in due course. These options can be further studied
# through ?par.
# The cleanest implementation is to open a new set of parameters, create the graph, and restore the
# original state, by means of the following simple but rather odd commands:
# Figure 8.1: Diameter/Height plot for all species of Upper Flat Creek inventory data. Each point represents
# a tree.
# opar <- par( {parameter instructions go here, separated by commas} )
# plot( {plot instructions go here} )
# par(opar)
# The reason that these work is that when the par() function is used to set a new parameter, it invisibly
# returns the previous value of that parameter. So, the code

opar <- par(las = 1)
# changes the las parameter to 1 and store las = 0 in opar. Subsequent invocation of
par(opar)
# changes the las parameter to 0 again.
# There are several options for aecting the layout of the graphs on the page. These can all be used in
# conjunction with one another. There are many more than I note below, but these are the ones that I end
# up using the most often. My most common par call is something like:
opar <- par(mfrow=c(3,2), mar=c(4,4,1,1), las=1)
plot(height.m ~ dbh.cm, data=ufc, xlab = "Diameter (cm)", ylab = "Height (m)")
par(opar)

# . par(mfrow=c(a,b)) where a and b are integers will create a matrix of plots on one page, with a
# rows and b columns.
# . par(mar=c(s,w,n,e)) will create a space of characters around the inner margin of the plot(s).
# . par(oma=c(s,w,n,e)) will create a space of characters around the outer margin of the plot(s).
# . par(las=1) rotates the y-axis labels to be horizontal rather than vertical.
# . par(pty="s") forces the plot shape to be square. The alternative is that the plot shape is mutable,
# which is the default, and is pty="m".




library(GGally)



summary(ufc)

qplot(sample=ufc$dbh.cm, stat="qq",xlab = "Diameter ")
  qqline(ufc$dbh.cm, col="red")


plot(density(ufc$dbh.cm))
abline(v=mean(ufc$dbh.cm),col="red")
abline(v=median(ufc$dbh.cm, na.rm = TRUE),col="blue")

qr(ufc$dbh.cm)
abline(v=sd(ufc$dbh.cm, na.rm = TRUE),col="red")
points(x=mean(ufc$dbh.cm), y=0.014)


ggally_facetdensity(ufc$dbh.cm, mapping)

?plot
?lines
?qplot
?GGally
?abline
?par

ufc <- read.csv("../data/ufc.csv")
str(ufc)

pairs(ufc,diag.panel=panel_diag <- function(x){hist(x)})
pairs(ufc[,4:5])
pairs(ufc[,1:2])
pairs(ufc[,3:4])
pairs(ufc[,c(3,5)])
pairs(ufc[,3:5])

ggpairs(ufc)
ggpairs(ufc[,4:5])

# este anda
ggpairs(ufc[,1:2])

ggpairs(ufc[,3:4])
ggpairs(ufc[,c(3,5)])
ggpairs(ufc[,3:5])

ggpairs(ufc[3:5],
        diag=list(continuous="density", discrete="bar"),
        axisLabels="show")

