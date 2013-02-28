# 6.3.3 Matrix (Array)

# A matrix is simply a vector that has extra attributes, called dimensions. R provides specic algorithms
# to enable us to treat the vector as though it were really two-dimensional. Many useful matrix operations
# are available.

?matrix

matrix(c(1,2,3,4),2)

dp <- c(1,2,3,4)
da <- c(5,6,7)
db <- c(8,9,10)

# matriz con 1 en dp
n <- 4
c(1,rep(0,n))
rep(c(1,rep(0,n)),n)[1:(n*n)-1]

mdp <- matrix(rep(c(1,rep(0,n)),n)[1:(n*n)] , n)

mdb <- matrix(rep(c(0,1,rep(0,n-1)),n)[1:(n*n)] , n)

mda <- matrix(rep(c(rep(0,n),1),n)[1:(n*n)] , n)

mdp * dp 
mda * c(0,da)
mdb * c(db,0)

mdp * dp + mdb * c(0,db) + mda * c(da,0)

length(dp)



# Busco una matriz de este tipo:
# |dp1  da1                 |
# |db1  dp2 da2             |
# |     db2  .     .        |
# |       .     .   da(n-1) |
# |          .     .        |
# |         db(n-1)   dpn   |
# Recive 3 vectores:
# dp la diagonal principal
# da la diagonal sobre la diagonal principal
# db la diagonal bajo la diagonal principal
crear_tri_diag <- function(dp, da, db)
{
  n <- length(dp)
  mdp <- matrix(rep(c(1,rep(0,n)),n)[1:(n*n)] , n)      # 1 en la diagonal, 0 en el resto
  mdb <- matrix(rep(c(0,1,rep(0,n-1)),n)[1:(n*n)] , n)  # 1 en la diagonal bajo la principal, 0 en el resto
  mda <- matrix(rep(c(rep(0,n),1),n)[1:(n*n)] , n)      # 1 en la diagonal sobre la principal, 0 en el resto
  return(mdp * dp + mdb * c(0,db) + mda * c(da,0))      # la tridiagonal buscada
}

crear_tri_diag(c(1:4), c(5:7), c(8:10))
#       [,1] [,2] [,3] [,4]
# [1,]    1    5    0    0
# [2,]    8    2    6    0
# [3,]    0    9    3    7
# [4,]    0    0   10    4
# 
crear_tri_diag(rep(2,10), rep(-1,9), rep(-1,9))


?diag
diag(1,4,3)

n <- 10000

system.time(
  mdp <- matrix(rep(c(1,rep(0,n)),n)[1:(n*n)] , n)      # 1 en la diagonal, 0 en el resto
)
  
system.time(
    mdp <- diag(1,n)                                      # 1 en la diagonal, 0 en el resto
)

?system.time


M <- 4 * diag(10)
1 * ((row(M) - col(M)) == 1)
1 * ((row(M) - col(M)) == -1)




crear_tri_diag <- function(dp, da, db)
{
  n <- length(dp)
  mdp <- diag(n)                                    # 1 en la diagonal, 0 en el resto
  mdb <- ((row(mdp) - col(mdp)) == 1)               # 1 en la diagonal bajo la principal, 0 en el resto
  mda <- ((row(mdp) - col(mdp)) == -1)              # 1 en la diagonal sobre la principal, 0 en el resto
  return(mdp * dp + mdb * c(0,db) + mda * c(da,0))  # la tridiagonal buscada
}








# Vectorization

# The concept underlying vectorization is simple: to make processing more ecient. Recall that in section
# 6.2.5, when we applied the is.na() function to the vector a it resulted in the function being applied to
# each element of the vector, and the output itself being a vector, without the user needing to intervene.
# This is vectorization.
# Imagine that we have a set of 1,000,000 tree diameters and we need to convert them all to basal area.
# In C or Fortran we would write a loop. The R version of the loop would look like this (wrapped in a
                                                                                       timer).
diameters <- rgamma(n=1000000, shape=2, scale=20)
basal.areas <- rep(NA, length(diameters))
system.time(
   for (i in 1:length(diameters)) {
     basal.areas[i] <- diameters[i]^2 * pi / 40000
     }
   )

