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

