# Chapter 3

# Showcase
# The goal of this chapter is to provide a whirlwind tour of some of the capabilities of R, in a relatively
# coherent work
# ow. You should study this chapter to get a sense of the kinds of things that R can do,
# without worrying too much about how it does them.
# Copy the code swatches you see here to the R console, and watch what happens. Try to relate what
# you see to your day-to-day analysis challenges.
# Don't worry too much about the nitty-gritty of execution. Some of what you see will be familiar, some
# will certainly not. Later on we will repeat these steps in a dierent context, and explain them more
# carefully.

# 3.1 Getting Ready

# Make sure that your directory structure is as laid out in Section 1.7, and the ufc.csv dataset is in the
# data directory. Then, start R in the manner appropriate to your operating system. Finally, make that
# directory your working directory, as follows. Select the Change dir... option from the File menu, and
# navigate to the scripts directoty inside the workshop directory. Click OK. At this point, the code below
# should work by Copy - Paste Commands Only without further intercession.

# 3.2 Data Input

# First, we read the data in from a comma-delimited le. The data are stand inventory data on a 300 ha
# parcel of the University of Idaho Experimental Forest, called the Upper Flat Creek stand. The sample
# design was a systematic sample of 7 m2/ha BAF variable radius plots; diameter measured for all trees
# and height for a subsample1. In the dataset, some plots are empty. Those plots are 
# agged by having
# trees with missing diameters and blank species.
ufc <- read.csv("../data/ufc.csv")
# Let's also input the sample design parameter and population size for later computation.
> ufc_baf <- 7
> ufc_area <- 300

# 3.3 Data Structure

# Here we examine the str()ucture of the data, check the rst few rows, and count the missing values (na)
# by column.
> str(ufc)
# 'data.frame': 637 obs. of 5 variables:
# $ plot : int 1 2 2 3 3 3 3 3 3 3 ...

# 1If you don't know what this means then don't worry about it. Seriously.

# $ tree : int 1 1 2 1 2 3 4 5 6 7 ...
# $ species: Factor w/ 13 levels "","DF","ES","F",..: 1 2 12 11 6 11 11 11 11 11 ...
# $ dbh : int NA 390 480 150 520 310 280 360 340 260 ...
# $ height : int NA 205 330 NA 300 NA NA 207 NA NA ...
> head(ufc) # los primeros 6
?head
tail(ufc) # los ultimos 6
# plot tree species dbh height
# 1 1 1 NA NA
# 2 2 1 DF 390 205
# 3 2 2 WL 480 330
# 4 3 1 WC 150 NA
# 5 3 2 GF 520 300
# 6 3 3 WC 310 NA
> colSums(is.na(ufc))  #  como los T=1 y F=0, esto cuenta cuantos NA tiene cada columna
?colSums
# plot tree species dbh height
# 0 0 0 10 246

# 3.3.1 Manipulation

# Ah, some diameters are missing. Those correspond to empty plots. Also, many heights are missing; the
# height attributes must have been subsampled. Next, obtain familiar units on our tree measurements (cm
#                                                                                                    for dbh and m for height, respectively).
# Note that we append the units to the variable names to be sure that the reader can easily interpret
# the statistics that we will later compute.
> ufc$height_m <- ufc$height/10
> ufc$dbh_cm <- ufc$dbh/10
# We now examine the structure again, using the str function.
> str(ufc)
# 'data.frame': 637 obs. of 7 variables:
# $ plot : int 1 2 2 3 3 3 3 3 3 3 ...
# $ tree : int 1 1 2 1 2 3 4 5 6 7 ...
# $ species : Factor w/ 13 levels "","DF","ES","F",..: 1 2 12 11 6 11 11 11 11 11 ...
# $ dbh : int NA 390 480 150 520 310 280 360 340 260 ...
# $ height : int NA 205 330 NA 300 NA NA 207 NA NA ...
# $ height_m: num NA 20.5 33 NA 30 NA NA 20.7 NA NA ...
# $ dbh_cm : num NA 39 48 15 52 31 28 36 34 26 ...
# We have created two more variables, which are now storred in our dataframe.

# 3.3.1 Manipulation
# Ah, some diameters are missing. Those correspond to empty plots. Also, many heights are missing; the
# height attributes must have been subsampled. Next, obtain familiar units on our tree measurements (cm
#                                                                                                    for dbh and m for height, respectively).
# Note that we append the units to the variable names to be sure that the reader can easily interpret
# the statistics that we will later compute.
ufc$height_m <- ufc$height/10
ufc$dbh_cm <- ufc$dbh/10



# 3.3.2 Data Summaries

# Now we obtain some useful snapshots of the data.
> range(ufc$dbh_cm)
# [1] NA NA
> range(ufc$height_m, na.rm = TRUE)
# [1] 0 48
# Zero height is a problem, because trees are usually taller than 0 m. Let's knock that observation out by

> ufc$height_m[ufc$height_m < 0.1] <- NA
> range(ufc$height_m, na.rm = TRUE)

# 3.5 Functions
# Functions exist to compute tree volume from diameter and height, by species (Wyko et al., 1982), for
# this geographical area. They look complex, but are easy to use, and ecient. Here we keep the unit
# conversions outside the function, but they could also be inside.
vol_fvs_ni_bdft <- function(spp, dbh_in, ht_ft){
 bf_params <-+ data.frame(
 species = c("WP", "WL", "DF", "GF", "WH", "WC", "LP", "ES",
 "SF", "PP", "HW"),
 b0_small = c(26.729, 29.790, 25.332, 34.127, 37.314, 10.472,
 8.059, 11.851, 11.403, 50.340, 37.314),
 b1_small = c(0.01189, 0.00997, 0.01003, 0.01293, 0.01203,
 0.00878, 0.01208, 0.01149, 0.01011, 0.01201, 0.01203),
 b0_large = c(32.516, 85.150, 9.522, 10.603, 50.680, 4.064,
 14.111, 1.620, 124.425, 298.784, 50.680),
 b1_large = c(0.01181, 0.00841, 0.01011, 0.01218, 0.01306,
 0.00799, 0.01103, 0.01158, 0.00694, 0.01595, 0.01306))
 dimensions <- data.frame(dbh_in = dbh_in,
 ht_ft = ht_ft,
 species = as.character(spp),
 this_order = 1:length(spp))
 dimensions <- merge(y=dimensions, x=bf_params, all.y=TRUE, all.x=FALSE)
 dimensions <- dimensions[order(dimensions$this_order, decreasing=FALSE),]
 b0 <- with(dimensions, ifelse(dbh_in <= 20.5, b0_small, b0_large))
 b1 <- with(dimensions, ifelse(dbh_in <= 20.5, b1_small, b1_large))
 volumes_bdft <- b0 + b1 * dimensions$dbh_in^2 * dimensions$ht_ft
 return(volumes_bdft)
 }

# Having saved the function we can use it in our code like any other function. One small complication is
# that the function was written for imperial units, so we have to take care of the unit conversion.
cm_to_inches <- 1/2.54
m_to_feet <- 3.281
bd_ft_to_m3 <- 0.002359737
# Now we can use the function that we wrote. What do you think we achieve by using with, below?
ufc$vol_m3 <- with(ufc, vol_fvs_ni_bdft(species,
 dbh_cm * cm_to_inches,
 p_height_m * m_to_feet) * bd_ft_to_m3)
# The following are examples of the construction of new variables. The variables are related to the analysis
# of forest inventory. Look away if such things disturb you. But, do execute them. If the execution is
# successful then you will get no feedback.
ufc$g_ma2 <- ufc$dbh_cm^2 * pi/40000
ufc$tree_factor <- ufc_baf/ufc$g_ma2
ufc$vol_m3_ha <- ufc$vol_m3 * ufc$tree_factor



# 3.6 Plot Level Processing
# Our next step is to aggregate the tree{level volume estimates to the plot level. First, we construct a
# dataframe (called ufc_plot that has the (known) plot locations. A dataframe will be dened more
# formally later, for the moment, treat it as a receptacle to keep variables in.
ufc_plot <- as.data.frame(cbind(c(1:144), rep(c(12:1),12),
  rep(c(1:12), rep(12,12))))
names(ufc_plot) = c("plot","north.n","east.n")
ufc_plot$north = (ufc_plot$north.n - 0.5) * 134.11
ufc_plot$east = (ufc_plot$east.n - 0.5) * 167.64
# Then we can construct plot-level values for any of the measured characteristics, for example, merchantable
# volume per hectare, by adding up the volumes per hectare of the trees within each plot. We know how
# to do this.
length(ufc_plot)
ufc_plot$vol_m3_ha <- tapply(ufc$vol_m3_ha, ufc$plot,sum, na.rm = TRUE)
