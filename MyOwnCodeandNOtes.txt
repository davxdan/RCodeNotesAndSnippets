repmis library

##Character
my_char<- c("My", "name", "is") #to create a character vector
c(my_char,"your_name_here")
paste(my_char, collapse = " ") #paste() function to concat together the elements of the my_char character vector with single spaces

#Numbers
num_vect<-c(.5,55,-10,6)#create a numeric vector
num_vect >=6  #show me anything greater than 6 True/false
paste(1:3, c("X", "Y", "Z"), sep = "") #[1] "1X" "2Y" "3Z"s Note that paste converts num to char
x<-c(44,NA,5,NA) #NA values x*3 [1] 132  NA  15  NA
my_data <- sample(c(y, z), 100)
my_na<-is.na(my_data)
#use == for equality !=` for inequality


#Data in vectors
#vectors come in integers and character strings
my_data[1:10] #First 10 from a vector (subset)
y <- x[!is.na(x)] #all non na values from x
#NA is not a value, but rather a placeholder for an unknown quantity
#the first element of a vector is considered element 1
x[c(3, 5, 7)] #subset the 3rd, 5th, and 7th elements of x
x[c(-2, -10)] #gives us all elements of x EXCEPT for the 2nd and 10 elements
c(foo = 11, bar = 2, norf = NA) #creates a vector with names
names(vect2) <- c("foo", "bar", "norf") #add the `names` attribute to vect2 after the fact
vect["bar"] #get element named bar
vect[c("foo","bar")] #specify a vector of names
my_vector<-1:20 #create a vector with numbers up to 20
length(my_vector)
dim(my_vector) <- c(4,5) #dim can get or set dimensions. Note this is now a matrix
#Matrices and dataframes
class(my_vector)
my_matrix<- my_vector #just renaming
patients<-c("Bill","Gina","Kelly","Sean") #create a row of names
cbind(patients,my_matrix) #add the names to the matrix. Note the datatype is now char for whole matrix. Matrices can only contain ONE class of data
my_data<-data.frame(patients,my_matrix) #created dataframe now with 2 datatypes
cnames<-c("patient", "age", "weight", "bp", "rating", "test")
colnames(my_data) <- cnames #set the column names

#lapply The 'l' in 'lapply' stands for 'list'. sapply simplifies lapply
cls_list <- lapply(flags, class) #to apply the class() function to each column of the flags
as.character(cls_list) #convert to char

#sapply every element is of length one, then sapply() returns a vector. If the result is a list where every element is a vector of the same length (> 1), sapply() returns a matrix.
cls_vect<-sapply(flags, class) #same but sapply
sum(flags$orange)
flag_colors <- flags[, 11:17] #to extract the columns containing the color data and store them in a new data frame called flag_colors. Note the comma before 11:17. This subsetting command tells R that we want all rows, but only columns 11 through 17.
lapply(flag_colors,sum) #makes a list
sapply(flag_colors,sum) #makes a vector
sapply(flag_colors,mean) 
flag_shapes <- flags[,19:23]
shape_mat<-sapply(flag_shapes,range)
unique_vals<-lapply(flags,unique)
sapply(unique_vals,length)
lapply(unique_vals, function(elem) elem[2]) # will return a list containing the second item from each element of the  unique_vals list.


#summary() 
#str()
#Stats
rnorm(1000) #Create random normal dist
z<- rep(NA,1000)
#df_titanicSex<- data.frame(df_titanic[,c("Sex")])
flips<-sample(c(0,1),100,replace=TRUE,prob = c(0.3, 0.7))
#mean of each column in my_pois using the colMeans() cm<-colMeans(my_pois), mean(c(2, 4, 5))
#hist(cm)
#ls() lists variables
#class()
#object.size(plants)
#names(plants)
#head() shows first 6 rows
#summary()
#modulus operator %% to find the remainder
#a list maycontain multiple data types

my_mean <- function(my_vector) {
  x<-sum(my_vector)
  y<-length(my_vector)
  x/y
}
# my_mean(c(4, 5, 10))
#optional default values... 2 for example below
#remainder <- function(num, divisor=2) {
#num %% divisor
#}

#evaluate <- function(func,dat){
#  func(dat)
#}
# Pass a function into a function evaluate(function(x){x+1}, 6)
#d1 <- Sys.Date()
#unclass(d1)
#d2<-as.Date("1969-01-01")
#t1<-Sys.time()mean
# use strptime(t3, "%B %d, %Y %H:%M") to help R convert our date/time object to a format that it understands
#Sys.time() > t1
#Sys.time() - t1
#difftime(Sys.time(), t1, units = 'days')