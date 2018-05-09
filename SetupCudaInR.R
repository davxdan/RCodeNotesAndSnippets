rm(list=ls())

#Sys.setenv(OPENCL_INC = "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v9.1/lib") #headers
#Sys.setenv(OPENCL_LIB32 = "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v9.1/lib") #32 library
#Sys.setenv(OPENCL_LIB64 = "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v9.1/lib")#64 library
#install.packages("gpuR")
#vignette("gpuR")

library(gpuR)
detectGPUs()

set.seed(123)
gpuA <- gpuMatrix(rnorm(16), nrow=4, ncol=4)
gpuB <- gpuA %*%

  
listContexts() #- provide list of available contexts with associated platform and device
currentContext()
currentPlatform()
currentDevice() # - as you would expect the current context, platform and device
setContext(3L) #- takes an integer argument (e.g. 1L) that references the corresponding context in listContexts(), I intend for this to be the current method for choosing a device. This is the simplest approach I can think of right now given the multiple platforms possible with OpenCL.

# example matrix multiplication test
library(gpuR)

# set first context as using Intel Core i7
setContext(2) #
A <- vclMatrix(rnorm(1000000), 100, 100)
B <- vclMatrix(rnorm(1000000), 100, 100)
system.time(A %*% B) 

# set second context as using Nvidia GTX 1050
setContext(3)
C <- vclMatrix(rnorm(1000000), 100, 100)
D <- vclMatrix(rnorm(1000000), 100, 100)
system.time(C %*% D)
