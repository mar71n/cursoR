library(reshape2)
library(reshape)

smiths <- data.frame(
  subject   = c("John Smith","Mary Smith"),
  time      = c(1   ,1   ),
  age       = c(33, 2),
  weight    = c(90, NA),
  height    = c(2,NA)
)

str(smiths)

melt(smiths, id=c("subject","time"), measured=c("age","weight","height"))
melt(smiths, id=c("subject","time"), measured=c("age"))
melt(smiths, id=c("subject","time"))
melt(smiths, id=1:2)
melt(smiths, measured=c("age","weight","height"))
melt(smiths)
smithsm <- melt(smiths, id=c("subject","time"))
str(smithsm)

melt(smiths,preserve.na=FALSE) # reshape pero no en reshape2
melt(smiths,na.rm=TRUE)        # reshape y reshape2

cast(smithsm, time + subject ~ variable) # en reshape2 es acast(smithsm, time + subject ~ variable)

cast(smithsm, ... ~ variable)

cast(smithsm, ... ~ subject)






?melt
?deshape
?cast
?reshape

# reshape tambien es una funcion del paquete stats
library(stats)
summary(Indometh)
wide <- reshape(Indometh, v.names = "conc", idvar = "Subject",
                timevar = "time", direction = "wide")
wide