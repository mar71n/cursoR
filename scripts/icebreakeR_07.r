# Chapter 7

# Simple Descriptions

# Ya tenemos visto un numero de diferentes                                      pero es util considerarlos 
# de un modo mas holistico y coordinado. Vamos a empezar por procesar los datos de acuerdo a nuestra primer estrategia
# We have already seen a number of different data summary and analysis tools, but it is useful to consider
# them in a more coordinated and holistic fashion. We start by reading and processing the data according
# to our earlier strategy.
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
# Here, we will drop the plots that have no trees, although we will keep track of them in the plot count.
# Aca esta, queremos dar de baja las parcelas que no tienen harboles, aunque queremos conservarlas para la cuenta de parcelas 
number.of.plots <- length(unique(ufc$plot)) # primero cuento las parcelas
ufc <- ufc[!is.na(ufc$dbh.cm), ]            # despues de contarlas, quito los registros sin harboles
ufc$species <- factor(ufc$species)

# 7.1 Univariate
# In what follows we distinguish between summaries of continuous data, also called numerical, and cate-
#   gorical data. Ordinal data can be considered a special case of the latter for our purposes. I don't see any
# particular reason to further subdivide continuous data into interval and ratio data.

7.1.1 Numerical
Getting standard estimates of the location and spread of variables is very easy; these are obtained by
the following commands. Note the use of the argument na.rm=TRUE, which tells R to ignore the missing
values.
Measures of location
> mean(ufc$dbh.cm, na.rm = TRUE)
[1] 35.65662
?mean # media aritmetica, promedio


> median(ufc$dbh.cm, na.rm = TRUE)
[1] 32.9

mode(ufc$dbh.cm)
summary(ufc$dbh.cm)


hist(ufc$dbh.cm)





# Measures of spread
> sd(ufc$dbh.cm, na.rm = TRUE)
[1] 17.68945
?sd # desviacion standar
> range(ufc$dbh.cm, na.rm = TRUE)
[1] 10 112
> IQR(ufc$dbh.cm, na.rm = TRUE)
[1] 23.45
?IQR
summary(ufc$dbh.cm)[[5]]-summary(ufc$dbh.cm)[[2]]

# Measures of skew
# A skewness() function can be found in the moments package. Alternatively we can compare the data with
# a known non-skewed dataset; the normal distribution (see Figure 7.1). These data are, not surprisingly,
# positively skewed (i.e. they have a long right tail).
> qqnorm(ufc$dbh.cm, xlab = "Diameter (cm)")  
> qqline(ufc$dbh.cm, col = "darkgrey")

?qqnorm

# Figure 7.1: Demonstration of normal quantile plot to assess skew. These data are, not surprisingly,
# positively skewed (i.e. they have a long right tail).
# El diametro no tiene asimetrias, es ecir tiene un tallo largo y derecho.

# 7.1.2 Categorical

# The most common data summary for categorical variables is tabulation. There are several ways that
# data can be tabulated in R. Their dierence is in how 
# exible the commands are and the kind of output
# generated.
> table(ufc$species)
DF ES GF HW LP PP SF WC WL WP
77 3 188 5 7 4 14 251 34 44
> tapply(ufc$species, ufc$species, length)


DF ES GF HW LP PP SF WC WL WP
77 3 188 5 7 4 14 251 34 44
 aggregate(x=list(count=ufc$species),
 by=list(species=ufc$species),
 FUN = length)
# species count
# 1 DF 77
# 2 ES 3
# 3 GF 188
# 4 HW 5
# 5 LP 7
# 6 PP 4
# 7 SF 14
# 8 WC 251
# 9 WL 34
# 10 WP 44
# These tables can be easily converted to gures (see Figure 7.2).
> plot(table(ufc$species), ylab = "Raw Stem Count")
> plot(as.table(tapply(ufc$tree.factor/number.of.plots, ufc$species,
                       + sum)), ylab = "Stems per Hectare")

# Figure 7.2: Raw count of trees by species (left panel) and weighted by tree factor (right panel).
# Continuous variates can also be converted into ordinal variates for further analysis using the cut()
# unction. For example, here we cut the tree diameters into 20 cm classes, making a new factor that has
# ordered levels.
> ufc$dbh.20 <- cut(ufc$dbh.cm, breaks = (0:6) * 20)
> table(ufc$dbh.20)
(0,20] (20,40] (40,60] (60,80] (80,100] (100,120]
128 279 163 43 11 3





# 7.2 Multivariate

# We will consider three cases that oer bivariate information; when there is conditioning on a categorical
# variable (e.g. species), and also when there is more than one variable of interest, be they numerical or
# categorical.

# 7.2.1 Numerical/Numerical

# We have already seen a scatterplot of two continuous variates, and we are not interested in formally
# tting models at this point. So, the correlation is a quick and useful summary of the level of agreement
# between two continuous variates. Note that the na.rm argument that we have become accustomed to is
# not used in this function, instead we use the use argument. See ?cor for more details.
> cor(ufc$dbh.cm, ufc$height.m, use = "complete.obs")
[1] 0.7794116 
?cor # Correlation, Variance and Covariance (Matrices)
cor.test(ufc$dbh.cm, ufc$height.m, use = "complete.obs")
?cor.test

7.2.2 Numerical/Categorical
We will most commonly be interested in obtaining summaries of the numerical variable conditioned upon
the categorical variable. We have seen how to do this in several ways. The main dierence between
the tapply() and aggregate() functions is in the structure of the output. tapply() creates a named
list, and aggregate() creates a dataframe with the labels as a separate column. Also, aggregate() will
compute the nominated function for more than one variable of interest.
> tapply(ufc$dbh.cm, ufc$species, mean, na.rm=TRUE)
DF ES GF HW LP PP SF WC
38.37143 40.33333 35.20106 20.90000 23.28571 56.85000 13.64286 37.50757
WL WP
34.00588 31.97273
> aggregate(x = list(dbh.cm=ufc$dbh.cm, height.m=ufc$height.m),
            + by = list(species=ufc$species),
            + FUN = mean, na.rm = TRUE)
species dbh.cm height.m
1 DF 38.37143 25.30000
2 ES 40.33333 28.00000
3 GF 35.20106 24.34322
4 HW 20.90000 19.80000
5 LP 23.28571 21.83333
6 PP 56.85000 33.00000
7 SF 13.64286 15.41000
8 WC 37.50757 23.48777
9 WL 34.00588 25.47273
10 WP 31.97273 25.92500
7.2.3 Categorical/Categorical
Numerical and graphical cross-tabulations are useful for summarizing the relationship between more than
one categorical variable.
> table(ufc$species, ufc$dbh.20)
(0,20] (20,40] (40,60] (60,80] (80,100] (100,120]
DF 10 33 27 5 2 0
ES 0 2 1 0 0 0
GF 37 88 47 12 4 0
HW 3 2 0 0 0 0
LP 2 5 0 0 0 0