#DSO102 - Statistical Programming in R
  #Lesson 4 - Vectors and Sample Statistics

  #Page 1 - Overview

#From workshop

#Error: missing ggplot pkg
height <- c(171, 192, 183, 177, 154, 176)

height_df <- data.frame(height)

d <- ggplot(height_df, aes(x = height))

d + geom_histogram(binwidth = 10) +
  ggtitle("Histogram of Heights") +
  xlab("Height (in cm)")

faithful_histogram <- ggplot(faithful, aes(x = eruptions))
faithful_histogram + geom_histogram()

#After installing ggpplot, runs successfully, with warning 
  #about bin size
height <- c(171, 192, 183, 177, 154, 176)

height_df <- data.frame(height)

d <- ggplot(height_df, aes(x = height))

d + geom_histogram(binwidth = 10) +
  ggtitle("Histogram of Heights") +
  xlab("Height (in cm)")

faithful_histogram <- ggplot(faithful, aes(x = eruptions))
faithful_histogram + geom_histogram()

#Error: missing + (at end of first line)
d + geom_histogram(binwidth = 10)
  ggtitle("Histogram of Heights") +
  xlab("Height (in cm)")
  
#Runs successfully 
Name <- c("Wolfbert", "BunBun", "Buffalump", "Roosevelt")

#Error: tried to do math with non-numeric string
Names + 1

#Error: console blocked with + instead of > until final 
  #parenthesis added
faithful_histogram <- ggplot(faithful, aes(x = eruptions)
                             
#Error: console blocked with + instead of > until final 
  #parenthesis added
faithful_histogram + geom_histogram(
  
#Error: missing comma between first 2 elements
height <- c(171 192, 183, 177, 154, 176)

#Error: missing comma between height_df and aes
d <- ggplot(height_df aes(x = height))

#Error: mistakenly capitalized Height_df (doesn't match 
  #variable height_df)
d <- ggplot(Height_df, aes(x = height))

#Error: 


  #Page 2 - Accessing Vectors
#From video
sleep_hours3 <- seq(6, 12, by = 0.5)
cat(sleep_hours3/n)
print(sleep_hours3)

sleep_hours4 <- seq(6, 12, length.out = 9)
print(sleep_hours3)

#From video - subsetting
sleep_hours5 <- sleep_hours [1]

#From lesson
heights <- c(171, 192, 183, 177, 154, 176)
heights[1]
heights[2]

1:10
100:1

seq(0, 1, by = 0.1)

seq(3, 5, length.out = 7)


  #Page 3 - Vector Arithmetic
#From video
sleep_hours7 <- sleep_hours / 2

bed_hours <- c(8, 9, 7, 8, 10, 7, 12)

sleep_efficiency <- sleep_hours / bed_hours *100

print(sleep_hours)

sleep_hours <- c(7, 8, 4, 8, 9, 5, 11)

sleep_efficiency

#From lesson
heights / 2.54
height[1] / 2.54
171 / 2.54

h_inch <- heights / 2.54

soles <- c(4, 1, 2, 6, 3, 5)

heights - soles

x <- c(1, 2)
y <- c(4, 5, 6, 7, 8, 9)
y - x
# above ^ y subtracts x, cycling through x in order repeatedly 
  # until all of y has been completed, which means to yield the 
  # results 3 3 5 5 7 7, it's done the math: 3 (4 - 1), 
  # 3 (5 - 2), 5 (6 - 1), 5 (7 - 2), 7 (8 - 1), 7 (9 - 2)

help(c)

n = 1:10
sqrt(n)

#From quiz
#Question 1
x <- c(1, 9, 6, 9, 5)
y <- c(4, 8, 2, 7, 7)
x + y


  #Page 4 - Logical Variables
# From video
62 < 67
62 > 67
62 <= 67
62 >= 67
62 == 67
62 != 67

#From lesson
Logic <- TRUE
Logic

3 < 5
3 > 5

#From quiz
#Question 1
4 < 6

#Question 2
4 == 6

#Question 3
4 != 6


  #Page 5 - Using Logical Operators with Vectors
#From video
#Using logical operators to determine logical 
  #values for vectors
sleep_hours <= 8
#results in logical vector:
  #[1]  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE

#Create a new vector with computed data from an 
  #alternate vector, using logical operators
enough_sleep <- sleep_hours[sleep_hours >=8]
enough_sleep
#new vector excludes all the FALSE values and contains all 
  #the TRUE values:
  #[1]  8  8  9 11

not_enough_sleep <- sleep_hours[sleep_hours <8]
not_enough_sleep
#new vector excludes all the FALSE values and contains all 
  #the TRUE values:
  #[1] 7 4 5

#Testing to see if vector name needs to be repeated out-
  #and inside of the brackets - and it does
not_enough_sleep <- sleep_hours[<8]
#results in: Error: unexpected '<' in 
  #"not_enough_sleep <- sleep_hours[<"

#From lesson
#Using logical operators to determine logical 
  #values for vectors
heights < 180
#results in logical vector:
  #[1]  TRUE FALSE FALSE  TRUE  TRUE  TRUE

#Create a new vector with computed data from an 
  #alternate vector, using logical operators
short <- heights[heights < 180]
short
#new vector excludes all the FALSE values and contains all 
  #the TRUE values:
  #[1] 171 177 154 176

#Create a new vector with computed data from an 
  #alternate vector, using logical operators
tall <- heights[heights >= 180]
tall
#new vector excludes all the FALSE values and contains all 
  #the TRUE values:
  #[1] 192 183

#Create new vector from another vector, removing a value 
  #from original vector with !=
new_heights <- heights[heights != 177]
new_heights
#new vector: [1] 171 192 183 154 176

#From quiz
#Q1
x <- c(1, 2, 3, 4, 5, 6)
y <- c(7, 6, 5, 4, 3, 2)
x <= y
#output: [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE

#Q2
arthur.dent <- c(1, 42, 4, 42, 42, 42, 9, 42, 16, 42, 42)

#a
arthur.dent[arthur.dent >= 42]
#output: [1] 42 42 42 42 42 42 42

#b: correct
arthur.dent[arthur.dent != 42]
#output: [1]  1  4  9 16

#c
arthur.dent[arthur.dent == 42]
#output: [1] 42 42 42 42 42 42 42

#d
arthur.dent[arthur.dent <= 42]
#output: [1]  1 42  4 42 42 42  9 42 16 42 42


  #Page 6 - Sample Statistics
#From video
#view data (table)
View(quakes)

#create a vector from a column on data table
magnitude <- quakes$mag
magnitude
#results in a vector named ‘magnitude’ being created from 
  #the data in the ‘mag’ column of the ‘quakes’ dataset

#view measures of central tendency for vector
mean(magnitude)
median(magnitude)
#results in: mean [1] 4.6204 | median [1] 4.6

#view measures of dispersion for vector
max(magnitude)
min(magnitude)
var(magnitude)
sd(magnitude)
#results in: max: [1] 6.4 | min: [1] 4 | var: [1] 0.1622261
  #sd: [1] 0.402773

summary(magnitude)
  #results in a quicker way of getting most of those above:
  #Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  #4.00    4.30    4.60    4.62    4.90    6.40

#view length, aka: sample size for vector
length(magnitude)


#From lesson
#Built in R data set for practice: 'faithful' has the 
  #length in minutes of 272 eruptions of the Old Faithful 
  # geyser as well as the waiting time in minutes to the 
  #next eruption

#load datasets
library(datasets)

#view 'faithful' dataset
faithful

#create new 'eruption_times' vector with eruptions column
  #from faithful data set, and view it
eruption_times <- faithful$eruptions

#view new vector
eruption_times

#view the vector's sample size
length(eruption_times)
#output: [1] 272

#view the vector's min and max values
min(eruption_times)
max(eruption_times)
#output: min [1] 1.6 | max [1] 5.1

#view the vector's mean and median values
mean(eruption_times)
median(eruption_times)
#output: mean [1] 3.487783 | median [1] 4

#view the vector's variance and standard deviation
var(eruption_times)
sd(eruption_times)
#output: var [1] 1.302728 | sd [1] 1.141371

#view summary sample statistics for the vector
summary(eruption_times)
#output 1:  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#output 2: 1.600   2.163   4.000   3.488   4.454   5.100 


#From quiz
#q1
wait_times <- faithful$waiting
mean(wait_times)
#output: 70.89706

#q2
median(wait_times)
#output: 76

#q3
min(wait_times)
#output: 43

#q3
max(wait_times)
#output: 96


  #Page 8 - Practice Hands-On Workshop
head(InsectSprays)

help(head)

View(InsectSprays)

#Create vector from count column on dataset
countVector <- InsectSprays$count

#Use logical operators with vector to separate out 
  #5 or fewer from 6 or more

fewBugs <- countVector[countVector <=5]
moreBugs <- countVector[countVector >5]

#Find how many elements are in each vector
length(fewBugs)
length(moreBugs)

#Find mean of each vector
mean(fewBugs)
mean(moreBugs)

#Find standard deviation of each vector
sd(fewBugs)
sd(moreBugs)