#General
rm(list=ls()) #to clear workspace


#file actions
library(RCurl) #for https site
test<- readLines("case0102.csv")
write.csv(test, file = "testWriteCSV.csv")
write.table(test, file = "testWriteTable.csv", col.names = FALSE, sep = ",")
test<- read.table ("case0102.csv",sep=",",header=TRUE)
head(test)
#install.packages('repmis')
#install.packages("countrycode")
library(repmis)
site<- "http://www.users.miamioh.edu/hughesmr/sta333/baseballsalaries.txt"
download.file(site,destfile ="./baseballsalaries.txt")
library(RCurl)
library(countrycode)

#Makefiles
#disable smartquotes, smartdashes
setwd("~/GitHub/RCodeNotesAndSnippets")
source("DansFirstMakeFile.txt")

#Download and open a zip file
library(RCurl)
fileURL<- "http://bit.ly/ijXJgDh"
temp<- tempfile()
download.file(fileURL,temp)
UDSData <- read.csv(gzfile(temp, "uds_summary.csv"))

fileURL<- "http://bit.ly/14aS5qq"
FinRegulatorData<- source_data(fileURL,sep=",",header = TRUE)
UrlAddress<- "https://raw.githubusercontent.com/christophergandrud/Disproportionality_Data/master/Disproportionality.csv"
DataURL<- getURL(UrlAddress)
DispropData<-read.table(textConnection(DataURL),sep=",",header=TRUE)
FinRegulatorData$iso2c<-countrycode(FinRegulatorData$country,origin="country.name",destination="iso2c")

##Character
my_char<- c("My", "name", "is") #to create a character vector
c(my_char,"your_name_here")
paste(my_char, collapse = " ") #paste() function to concat together the elements of the my_char character vector with single spaces

#Reg Expressions
grep("Female",test)
grep("[Aa]ria",test) #this wasnt working bc the file wasn't using ""
grep("^I",test) #look for things beginning with "I"
grep("I?",test) #look for things ending with "I"
grep("[0-9]",test) #find numbers
grep("9.11",test) #"." is wildcard for between
grep("a|b",test) #find a or b
test[c(16:18)]


#Numbers
num_vect<-c(.5,55,-10,6)#create a numeric vector
num_vect >=6  #show me anything greater than 6 True/false
paste(1:3, c("X", "Y", "Z"), sep = "") #[1] "1X" "2Y" "3Z"s Note that paste converts num to char
x<-c(44,NA,5,NA) #NA values x*3 [1] 132  NA  15  NA
my_data <- sample(c(y, z), 100)
my_na<-is.na(my_data)
# == for equality !=` for inequality

#Data Manipulation
#Melting or "stacking" data means using column headers as values (like key value pairs). "RoW", "Column", "Value". #Casting is opposite of melting.
#dplyr and plyr for data trnsforms
#cbind (for columns) rbind(for rows)
#install.packages('WDI') #World Development Indicators from World Bank
library(WDI)
WDIsearch("fertilizer consumption")
FertConsumpData<-WDI(indicator="AG.CON.FERT.ZS")
#install.packages("tidyverse")
head(FertConsumpData)
class(FertConsumpData)
library(tidyverse)
SpreadFert<-spread(FertConsumpData, year, AG.CON.FERT.ZS) #convert long to wide. Transposed year
head(SpreadFert)#transposed
SpreadFert<-arrange(SpreadFert, country) #arranged by country alphabetically
GatheredFert<-gather(SpreadFert,Year,Fert,3:9)#Gather columns 3-9.Year now a factor rather than numeric.
head(GatheredFert)
GatheredFert<-rename(GatheredFert,year=Year,FertilizerConsumption=Fert) #Rename columns
GatheredFert<-GatheredFert[order(GatheredFert$country,GatheredFert$year),] #Sort data
FertOutliers<- subset(x = GatheredFert, FertilizerConsumption > 1000) #get only outliers
GatheredFertSub <- subset(x = GatheredFert, FertilizerConsumption <= 1000)
GatheredFertSub <- subset(x = GatheredFertSub, country != "Arab World")#subset the subset excluding bad records
GatheredFertSub<- subset(x = GatheredFertSub, !is.na(FertilizerConsumption)) #y <- x[!is.na(x)] #all non na values from x

#Updating Values
#unique(GatheredFertSub$country)
GatheredFertSub$country[GatheredFertSub$country == "Korea, Rep."]<-"South Korea" #For numbers do same except no quotes ""
GatheredFertSub$logFertConsumption <- log(GatheredFertSub$FertilizerConsumption)
#summary(GatheredFertSub$logFertConsumption) #because some had zero we see infinite values in summary.
GatheredFertSub$FertilizerConsumption[GatheredFertSub$FertilizerConsumption == 0]<-.001 #Replace 0's with small value to resolve infinite summary stats 
GatheredFertSub$logFertConsumption <- log(GatheredFertSub$FertilizerConsumption)
attach(GatheredFertSub) #attach to R so we can use variables without the $
#Categorize data by adding a column populated based on criteria
GatheredFertSub$ConsGroup[FertilizerConsumption <=18]<-1
GatheredFertSub$ConsGroup[FertilizerConsumption >18 & FertilizerConsumption <=81]<-2
GatheredFertSub$ConsGroup[FertilizerConsumption >81 & FertilizerConsumption <=158]<-3
GatheredFertSub$ConsGroup[FertilizerConsumption >158]<-4
#unique(GatheredFertSub$ConsGroup)
FClabels<-c("low", "medium low","medium high", "high") #create labels
GatheredFertSub$ConsGroup<-factor(GatheredFertSub$ConsGroup, labels = FClabels) #change or "coerce" datatype to factor and add labels. Other way is to use "as."
#summary(GatheredFertSub$ConsGroup)
#look into using the cut() function

#problems with this because FinRegulatorData not found at URL
#Merge Parameter all=FALSE (only matching rows are returned) 
MergeData1 <- merge(x= FinRegulatorData, y=DispropData, by = "iso2c", all=TRUE) #Join data
MergeData2 <- merge(x= FinRegulatorData, y=DispropData, union("x","y"), all=TRUE)
dataduplicates<-MergeData2[duplicated(MergeData2[,1:2]),]

#Graphics (for more advanced graphics in R see lattice, ggplot2 and ggvis)
#http://www.ling.upenn.edu/~joseff/rstudy/week4.html
library(ggplot2)
ggplot(data = GatherFert,aes(FertilizerConsumption))+geom_density()
plot(cars) #Note that 'plot' is short for scatterplot
plot(x = cars$speed, y = cars$dist)
plot(x = cars$speed, y = cars$dist, xlab = "Speed", ylab="Stopping Distance")
#to explore the many other options, look at ?par,?points
plot(cars, col = 2)
plot(cars, xlim = c(10,15))
plot(cars, pch = 2)
data(mtcars)
boxplot(formula = mpg ~ cyl,data = mtcars)
hist(mtcars$mpg)
data(cars)#some data have help type ?cars
#vectors come in integers and character strings
my_data[1:10] #First 10 from a vector (subset)

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
sample = c(1.7, 1.6, 1.5, 2.0, 2.3, 1.6, 1.6, 1.8, 1.5, 1.7, 1.2, 1.4, 1.6, 1.6, 1.6)
t.test(x=sample, mu = 1.8, conf.int = "TRUE", alternative = "two.sided" )

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

#functions
my_mean <- function(my_vector) {
  x<-sum(my_vector)
  y<-length(my_vector)
  x/y
}
my_mean(c(4, 5, 10))
#optional default values... 2 for example below
remainder <- function(num, divisor=2) {num %% divisor}
evaluate <- function(func,dat){  func(dat)}

# Pass a function into a function evaluate(function(x){x+1}, 6)
d1 <- Sys.Date()
unclass(d1)
d2<-as.Date("1969-01-01")
t1<-Sys.time()mean
strptime(t3, "%B %d, %Y %H:%M") #to help R convert our date/time object to a format that it understands
Sys.time() > t1
Sys.time() - t1
difftime(Sys.time(), t1, units = 'days')

#Scraping Data
#http://www.json.org/
library(RJSONIO)
library(jsonlite)
swdf = as.data.frame(rbind(c("Anakin", "male", "Tatooine", "41.9BBY", "yes"), c("Amidala", "female", "Naboo", "46.9BBY", "no")))
names(swdf)=c("Name", "Gender","Homeworld","Born","Jedi")
sw_json<- toJSON(swdf)
class(sw_json)
sw_R <- fromJSON(sw_json)

#json from a website
json_file <- "https://jsonplaceholder.typicode.com/posts"
data <- fromJSON(json_file)
class(data)
#stopwords
