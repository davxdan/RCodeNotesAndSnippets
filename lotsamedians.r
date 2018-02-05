
#Sample Size of 10
sessionInfo()
n<- 15 #set a variable for the sample size of 10
nsim <- 1 #set a variable to hold the number of loops. In this case 1000 
lotsa.medians <- numeric(nsim) #initialize a numeric variable to hold the result of each loop
for (i in 1:nsim) { #for each integer from 1 through 1000 
  x <- rnorm(n) #set the variable x to a random exponential distribution with sample size 10 (stored in the n variable).
  lotsa.medians[i] <- median(x)} #store the median of the each iteration in the lotsa.medians variable
hist(lotsa.medians) #display a histogram with the 1000 randomly generated medians as input
abline(v=0,col="blue", lwd=2) #draw a blue line at the 0 vector with weight of 2


#length (lotsa.medians)

#summary(lotsa.medians)

#sample size of 50
sessionInfo()
n<- 50 #set a variable for the sample size of 50
nsim <- 1000 #set a variable to hold the number of loops. In this case 1000 
lotsa.medians <- numeric(nsim) #initialize a numeric variable to hold the result of each loop
for (i in 1:nsim) { #for each integer from 1 through 1000 
  x <- rexp(n) #set the variable x to a random exponential distribution with sample size 50 (stored in the n variable).
  lotsa.medians[i] <- median(x)} #store the median of the each iteration in the lotsa.medians variable
hist(lotsa.medians) #display a histogram with the 1000 randomly generated medians as input
abline(v=0,col="blue", lwd=2) #draw a blue line at the 0 vector with weight of 2