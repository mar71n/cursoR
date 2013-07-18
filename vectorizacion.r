# Vectorization

# The concept underlying vectorization is simple: to make processing more effcient. Recall that in section
# 6.2.5, when we applied the is.na() function to the vector a it resulted in the function being applied to
# each element of the vector, and the output itself being a vector, without the user needing to intervene.
# This is vectorization.
# Imagine that we have a set of 1,000,000 tree diameters and we need to convert them all to basal area.
# In C or Fortran we would write a loop. The R version of the loop would look like this (wrapped in a
# timer).
diameters <- rgamma(n=1000000, shape=2, scale=20)
str(diameters)                                                                                       
basal.areas <- rep(NA, length(diameters))
str(basal.areas)
system.time(
  for (i in 1:length(diameters)) {
    basal.areas[i] <- diameters[i]^2 * pi / 40000
    }
  )
# user system elapsed
# 3.088 0.014 3.102

# That took just over three seconds on my quite old computer. However, if we vectorize the operation,
# it becomes considerably faster.
system.time(
  basal.areas <- diameters^2 * pi / 40000
)
# user system elapsed
# 0.013 0.006 0.019

# It's about 250 times faster. Of course, had we programmed this function in C or Fortran, the outcome
# would have been much faster still. 

# The R programming mantra might be: 
# compile only if you need to, loop only if you have to, and vectorize all the time.
# Compila solo cuando sea nesesario, itera solo cuando tengas que hacerlo, y vectoriza siempre.

# Vectorization only works for some functions; e.g. it won't work for mean(), because that would make
# no sense; we want the mean of the numbers in the vector, not the mean of each individual unit. But,
# when vectorization works it makes life easier, code cleaner, and processing time faster.
# Note that pi is a single value, and not of length 10^6 , and R assumed that we would like it repeated
# 10^6 times. This is called recycling.

# Recycling
# You may have noticed above that R provided a convenience for the manipulation of vectors. When we
# typed
a <- c(11,12,13)
a + 1
# [1] 12 13 14
# R assumed that we wanted to add 1 to each element of a. This is called recycling, and is usually very
# useful and occasionally very dangerous. R recycled 1 until it had the same length as a. interpreted the
# function as:
a + c(1, 1, 1)
# [1] 12 13 14
# For a further example, if we want to convert all the numbers in a vector from inches to centimetres,
# we simply do
(a <- a * 2.54)
# [1] 27.94 30.48 33.02
# Recycling can be dangerous because sometimes we want the dimensions to match up exactly, and
# mismatches will lead to incorrect computations. If we fail to line up our results exactly - e.g. because
# of some missing values - R will go ahead and compute the result anyway. The only way to be sure is to
# watch for warnings, examine the output carefully, and keep in mind that most of the time this facility is
# really helpful.
a + c(1, -1)
# [1] 28.94 29.48 34.02


v <- matrix(c(1:30),nrow=10,ncol=3)
v
?aggregate
v <- as.data.frame(v)
mean(v)
rapply(v,sum)
as.data.frame(apply(t(v),FUN=mean))
