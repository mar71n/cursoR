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

qplot( dbh.cm,height.m , data=ufc, xlab = "Diameter (cm)", ylab = "Height (m)")

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
# . par(new=TRUE) when inserted between plots will plot the next one on the same place as the previous,
# efecting an overlay. It will not match the axes unless forced to do so. Increasing the mar parameters
# for the second plot will force it to be printed inside the rst plot.
# . Various character expansion factors may also be set.
# You can also interrogate your last graph for details. For example,
par("usr")
# [1] 5.920 116.080 1.616 49.784
# gives you the realized axis limits (compare with Figure 8.1).

# 8.2 Graphical Augmentation
# A traditional plot, once created, can be augmented using any of a number of dierent tools.
# The infrastructure of the plot can be altered. For example, axes may be omitted in the initial plot
# call (axes = FALSE) and added afterwards using the axis() function, which provides greater control and
# 
# exibility over the locations and format of the tickmarks, axis labels, and also the content. Note that
# axis() only provides axis information within the portion of the range of the data, to reduce unnecessary
# plot clutter. The usual plot frame can be added using the box() function. Text can be located in the
# margins of the plot, to label certain areas or to augment axis labels, using the mtext() function. A
# legend can be added using the legend() function, which includes a very useful legend location routine,
# as shown below. Additions can also be made to the content of the plot, using the points(), lines(),
# and abline() functions. A number of these dierent steps are shown in gure 8.2.

# 1. Start by creating the plot object, which sets up the dimensions of the space, but omit any plot
# objects for the moment.
par(las = 1, mar=c(4,4,3,2))
plot(ufc$dbh.cm, ufc$height.m, axes=FALSE, xlab="", ylab="", type="n")

# 2. Next, we add the points. Let's use dierent colours for dierent trees.
points(ufc$dbh.cm, ufc$height.m, col="darkseagreen4")
points(ufc$dbh.cm[ufc$height.m < 5.0],
 ufc$height.m[ufc$height.m < 5.0], col="red")

# 3. Add axes. These are the simplest possible calls, we have much greater 
# exibility than shown here.
axis(1)
axis(2)

# 4. Add axis labels using margin text (switching back to vertical for the y-axis).
par(las=0)
mtext("Diameter (cm)", side=1, line=3, col="blue")
mtext("Height (m)", side=2, line=3, col="blue")

# 5. Wrap the plot in the traditional frame.
box()

# 6. Finally, add a legend.
legend("bottomright",
 c("A normal tree", "A weird tree"),
 col=c("darkseagreen3","red"),
 pch=c(1,1),
 bty="n")

# 8.3 Permanence
# Producing more permanent graphics is just as simple. For example, to create the graphic as a pdf le,
# which can be imported into various documents, we do the following:
pdf(file="../graphics/graphic.pdf")
plot(ufc$dbh.cm, ufc$height.m)
abline(lm(height.m ~ dbh.cm, data=ufc), col="red")
dev.off()
# This will place the pdf in your graphics directory. This is an especially good option if the graphics
# that you want to produce would ordinarily cover more than one page, for example, if you are producing
# graphs in a loop. The pdf format is well accepted on the Internet as well, so the graphics are portable.
# Encapsulated postscript is also supported.
# Under Windows, you can also copy directly from the plot window to the clipboard as either a metale
# or a bmp (bitmap) image. Either can then be pasted directly into a Word document, for example.
# Alternatively using a similar approach to that noted above, one can create a JPEG image which can be
# imported into Word documents. My experience has been that the vividness of the colour suers using
# JPEG, and some ameliorative action might be required.

# 8.4 Upgrades
# The joy of advanced graphics in R is that all the good images can be made using the tools that we've
# already discussed. And, because the interface is scripted, it's very easy to take graphics that were created
# for one purpose and evolve them for another. Looping and judicious choice of control parameters can
# create informative and attractive output. For example, Figure 8.3 is constructed by the following code.
opar <- par(oma=c(0,0,0,0), mar=c(0,0,0,0))
x1 <- rep(1:10, 10)
x2 <- rep(1:10, each=10)
x3 <- 1:100
interesting.colour.numbers <- c(1:152,253:259,362:657)
plot.us <- sample(interesting.colour.numbers, size=max(x3))
plot(x1, x2, col=colors()[plot.us], pch=20, cex=10, axes=F,
 ylim=c(0,10), xlim=c(0, 10.5))
text(x1, x2-0.5, colors()[plot.us], cex=0.3)
text(x1+0.4, x2-0.4, plot.us, cex=0.5)
par(opar)

# 8.5 Common Challenges
# This section is devoted to showing how to solve common graphical challenges using R.
# 8.5.1 Error Bars
# Often we are asked to provide graphs that have error bars. We can use the arrows() function to provide
# the bars, and vectorization will keep the code simple for us. Figure 8.4 shows the mean and a 95%
# condence interval (unweighted!) for the tree diameters by species.
ufc_ <- ufc[ufc$species!='',]
ufc_$species <- factor(ufc_$species)
means <- tapply(ufc_$dbh.cm, ufc_$species, mean, na.rm=F)
ses <- tapply(ufc_$dbh.cm, ufc_$species, sd, na.rm=TRUE) /
 sqrt(tapply(!is.na(ufc_$dbh.cm), ufc_$species, sum))
ylim <- range(c(means + 1.96*ses, means - 1.96*ses))
par(las=1, mar=c(4,4,2,2))
plot(1:10, means, axes=FALSE, ylim=ylim, xlab="Species", ylab="Dbh (cm)")
axis(1, at=1:10, labels=levels(ufc_$species))
axis(2)
arrows(1:10, means-1.96*ses, 1:10, means+1.96*ses,
 col="darkgrey", angle=90, code=3, length=0.1)

# 8.5.2 Colour graphics by groups
# Integrating useful colour in another common challenge. There exist packages that contain functions to
# do this quickly and easily (lattice, see Section 8.6.1, and car, to name just two) but it is worth seeing
# how to do this with the tools available.
# Using all the available species will make quite a mess, so let's constrain ourselves to trees from the
# four most common. The following code identies the four most common species and constructs a smaller
# dataframe that contains trees only of those species.
top.four <- levels(ufc$species)[order(table(ufc$species),
 decreasing=TRUE)][1:4]
ufc.small <- ufc[ufc$species %in% top.four,]
ufc.small$species <- factor(ufc.small$species)
# Now we can construct the plot using that smaller dataframe as follows (see Figure 8.5).
my.colours <- c("red","blue","goldenrod","darkseagreen4")
par(las=1, mar=c(4,4,3,2))
plot(ufc.small$dbh.cm, ufc.small$height.m,
 xlab = "Dbh (cm)", ylab = "Height (m)",
 col = my.colours[ufc.small$species])
legend("bottomright",
 legend = levels(ufc.small$species),
 col = my.colours,
 lty = rep(NULL, 4),
 pch = rep(19, 4),
 bty = "n")

# 8.6 Contributions
# Contributers to R have written packages that ease the construction of graphics. We will explore some of
# them here. Documentation of these facilities is challenging because the code is under continuous review
# and development.
# 8.6.1 Trellis
# Trellis is a more formal tool for graphical virtuosity. Trellis allows great 
# exibility for producing con-ditioning plots. The R implementation of trellis is called lattice, and is written mainly by Deepayan
# Sankar.
# We load the lattice package by means of the library function, which is explained in greater detail
# in Appendix A.
library(lattice)
# The goal of lattice is to simplify the production of high-quality and simple graphics that permit
# multi-dimensional data summaries.
# We have already seen the use of these graphics in the Showcase chapter (Chapter 3), where we plotted
# height against diameter for each species, as well as diameter distributions for each species. We can get
# other useful graphics with a minimum of fuss, for example, focusing on the four most prolic species in
# the ufc data (Figure 8.6).
ufc <- read.csv("../data/ufc.csv") # ufc is a dataframe
ufc$dbh.cm <- ufc$dbh/10 # Dbh now in cm
ufc$height.m <- ufc$height/10 # Height now in metres
ufc$height.m[ufc$height.m < 0.1] <- NA
ufc <- ufc[complete.cases(ufc),]
ufc$species[ufc$species %in% c("F","FG")] <- "GF"
ufc$species <- factor(ufc$species)
top.four <- levels(ufc$species)[order(table(ufc$species),
 decreasing=TRUE)][1:4]
# The panels in the following list refer directly to Figure 8.6 and do not necessarily correspond in
# position to what you will see on your screen.
#  Top left panel:
densityplot(~ dbh.cm | species, data=ufc,
 subset=species %in% top.four)
#  Top right panel:
bwplot(dbh.cm ~ species, data=ufc, subset=species %in% top.four)
#  Bottom left panel:
histogram( ~ dbh.cm | species, data=ufc,
 subset=species %in% top.four)
#  Bottom right panel:
#   (The object that we are loading was created in the Showcase chapter.)
#load("../images/ufc_plot.RData")
load("../images/indultos_x_annio.png")
contourplot(vol_m3_ha ~ east * north,
 main = expression(paste("Volume (", m^3, "/ha)", sep="")),
 xlab = "East (m)", ylab="North (m)",
 region = TRUE,
 col.regions = terrain.colors(11)[11:1],
 data=ufc_plot)
# Graphics produced by lattice are highly customizable. For example, if we were to wish to plot
# the height against the predicted height for the six species with the largest number of trees, using the
# mixed-eects imputation model from Chapter 3, and add some illustrative lines to the graphs, then we
# could do it with the following code. First we t a suitable model and extract the predictions, to be used
# as imputations.  
#   



library(nlme)
hd.lme <- lme(I(log(height.m)) ~ I(log(dbh.cm)) * species,
                 random = ~ I(log(dbh.cm)) | plot,
                  data = ufc)
ufc$p.height.m <- exp(predict(hd.lme, level=1))
top.six <- levels(ufc$species)[order(table(ufc$species),
                                        decreasing=TRUE)][1:6]
library(MASS)



hd.lm <- lm(I(log(height.m)) ~ I(log(dbh.cm)) * species,
 data = ufc)
ufc$p.height.m <- exp(predict(hd.lm))
# We can change the order of the panels using the index.cond option. We can also add other commands
# to each panel. ?xyplot is very helpful to us here, providing very detailed information about the various
# options, and some attractive examples that we can adapt to our own uses.
# Even though the code is quite mature, it is still under development to ease usage. For example, in
# up-to-date versions of lattice, to obtain a trellis plot that has points, regression lines of best t, and
# smoothers superimposed, we need merely the following code:
xyplot(height.m ~ p.height.m | species, data = ufc,
            xlab = "Predicted Height (m)",
            ylab = "Measured Height (m)",
            type = c("p", "r", "smooth"),
            subset = species %in% top.six
            )
# Figure 8.7: A lattice plot of height against predicted height by species for the six species that have the
# most trees. The blue dashed line is 1:1, the red solid line is the panel-level regression, the purple solid
# line is a robust regression t and the black curved line is a loess smooth.




# 8.6.2 Grammar of Graphics
# The key reference is now in its second edition (Wilkinson, 2005). Hadley Wickham has developed tools
# within R to realize some of the Grammar principles in an easily-usable format. The code is in version
# 2, and the original version is being phased out (\deprecated") hence we use the ggplot2 package. This
# package is still under heavy development, but it also looks like a promising contribution to simplify
# statistical communication.
library(ggplot2)
# The dierences between lattice and ggplot2 are mostly cosmetic. Publcation-quality graphics can be
# easily constructed using each of them, with patience. I nd that ggplot2's ability to seamlessly add data
# from a range of sources greatly eases the challenge of juxtaposing model predictions and observations,
# but as we saw in the previous section, lattice has a somewhat more straightforward interface.
# Getting Started
# We trace some very simple developments in Figure 8.8.
# 1. Start by creating the plot space, and add points. Below, we identify the object to use, then pick
# out the so-called aesthetic elements of the object, and then tell R how to display them.
ggplot(ufc, aes(y = height.m, x = dbh.cm)) + geom_point()
# 2. Now we add a smooth line and (automatically) standard error spaces. The standard error polygon
# is attractive but its value is questionable, because it is point-wise, not curve-wise. So, it looks as
# though it tells us something really useful, but sadly, it does not.
ggplot(ufc, aes(y = height.m, x = dbh.cm)) + geom_point() +
 stat_smooth(fill = "blue", alpha = 0.2,
 colour = "darkblue", size = 2)













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

