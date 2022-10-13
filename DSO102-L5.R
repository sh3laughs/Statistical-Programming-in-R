#DSO102 - Statistical Programming in R
  #Lesson 5 - Statistical Plots

  #Page 2 - What is ggplot2?

#From workshop
#Create a histogram with suitable bin widths for the # of 
  #absences each student has
ggplot(student_mat, aes(x=absences)) +
  geom_histogram()

ggplot(student_mat, aes(x=absences)) +
  geom_histogram(bins = 50)

ggplot(student_mat, aes(x=absences)) +
  geom_histogram(bins = 50) +
  ggtitle("Number of Student Absences") +
  xlab("Student Absences") +
  ylab("Frequency Count")

#Create a boxplot with suitable bin widths for the # of 
  #absences each student has
ggplot(student_mat, aes(y=absences)) +
  geom_boxplot() +
  ggtitle("Number of Student Absences") +
  xlab("Student Absences") +
  ylab("Frequency Count")

#Color the outliers red
ggplot(student_mat, aes(y=absences)) +
  geom_boxplot(outlier.color = "red") +
  ggtitle("Number of Student Absences") +
  xlab("Student Absences") +
  ylab("Frequency Count")
#There are high outliers here (above)

#Create a normal probability plot with suitable bin widths for 
  #the # of absences each student has
ggplot(student_mat, aes(sample=absences)) +
  geom_qq() +
  ggtitle("Number of Student Absences") +
  xlab("Student Absences") +
  ylab("Frequency Count")

#From video
  #load packages
library(ggplot2)
library(gridExtra)

#From lesson - install a bunch of packages
install.packages("ggplot2")
install.packages("datasets")
install.packages("readxl") 
install.packages("dplyr") 
install.packages("PerformanceAnalytics")
install.packages("corrplot") 
install.packages("gapminder")
install.packages("gridextra")
install.packages("Ecdat")
install.packages("corpcor")
install.packages("GPArotation")
install.packages("psych")
install.packages("IDPmisc")
install.packages("lattice") 
install.packages("treetop")
install.packages("scales")
install.packages("rcompanion")
install.packages("gmodels")
install.packages("car")
install.packages("caret")
install.packages("gvlma")
install.packages("predictmeans")
install.packages("caret")
install.packages("magrittr")
install.packages("tidyr")
install.packages("lmtest")
install.packages("popbio")
install.packages("e1071")
install.packages("data.table")
install.packages("effects")
install.packages("multcomp")
install.packages("mvnormtest")


  #Page 3 - Histograms
#From video
library(ggplot2)

  #view dataset
View(warpbreaks)

  #set up histogram
weaving <- ggplot(warpbreaks, aes(x = breaks))
weaving + geom_histogram()

  #update binwidth, per warning
weaving <- ggplot(warpbreaks, aes(x = breaks))
weaving + geom_histogram(binwidth = 10)

  #pretty up the histogram
weaving + geom_histogram(binwidth = 10, 
                         color = "blue", fill = "dark blue") +
  ggtitle("Histogram of Warp Breaks When Weaving") +
  xlab("Warp breaks") +
  ylab("Count of Values")


#From lesson
  #(re)assign vector to variable name
height <- c(171, 192, 183, 177, 154, 176)

  #create histogram with heights
h <- ggplot(height_df, aes(x = height))
h + geom_histogram()
#gives warning: `stat_bin()` using `bins = 30`. Pick better value 
#with `binwidth`.

#Update binwidth
h + geom_histogram(binwidth = 10)

  #Add titles
h + geom_histogram(binwidth = 10) +
  ggtitle("Histogram of Heights") +
  xlab("Height (in cm)")

  #Relative frequencies
h + geom_histogram(binwidth = 10, aes(y = ..count../sum(..count..))) +
  ggtitle("Histogram of Heights") + xlab("Height (in cm)") +
  ylab("Relative frequency")

  #Color the chart
h + geom_histogram(binwidth = 10, aes(y = ..count../sum(..count..)), fill = "goldenrod", color = "deepskyblue4") +
  ggtitle("Histogram of Heights") + xlab("Height (in cm)") +
  ylab("Relative frequency")

  #Revert to counts
h + geom_histogram(binwidth = 10, fill = "goldenrod", color = "deepskyblue4") +
  ggtitle("Histogram of Heights") + xlab("Height (in cm)")

  #Create histogram from new dataset
faithful_histogram <- ggplot(faithful, aes(x = eruptions))
faithful_histogram + geom_histogram()
#gives warning: `stat_bin()` using `bins = 30`. Pick better value 
#with `binwidth`.

  #Add breaks for bins with 0.2 widths
faithful_histogram + geom_histogram(breaks = seq(1.4, 5.2, by = 0.2))


#From quiz
#q2
waiting_histogram <- ggplot(faithful, aes(x = waiting))
waiting_histogram + geom_histogram(binwidth = 3)



  #Page 4 - Box Plots
library(ggplot2)

#From video
weaving_boxplot <- ggplot(warpbreaks, aes(x = "", y = breaks))
weaving_boxplot + geom_boxplot() +
  xlab("")

#Mathematically screen for outliers

summary(warpbreaks)
#output:
  #breaks      wool   tension
  #Min.   :10.00   A:27   L:18   
  #1st Qu.:18.25   B:27   M:18   
  #Median :26.00          H:18   
  #Mean   :28.15                 
  #3rd Qu.:34.00                 
  #Max.   :70.00  

#IQR = 3Q - 1Q
IQR <- 34 - 18.25
#output: 15.75

outlierRange <- IQR * 1.5
#output: 23.625

34 + outlierRange
#output: 57.625

18.25 - outlierRange
#output: -5.375

#outliers: anything above 57.625 or below -5.375


#From lesson
View(cars)

  #create boxplot
stoppingDistanceBoxplot <- ggplot(cars, aes(x="", y = dist))
stoppingDistanceBoxplot + geom_boxplot() +
  xlab("")

  #view summary info
summary(cars$dist)
#output:
  #   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  #   2.00   26.00   36.00   42.98   56.00  120.00

  #find IQR
carsIqr <- 56 - 26
#output: 30

  #find outlier range
outlierRangeCars <- carsIqr * 1.5
#output: 45

  #find max value before outliers
56 + outlierRangeCars
#output: 101

  #find min value before outliers
26 - outlierRangeCars
#output: -19

#outliers: anything above 101 or below -19



  #Page 5 - Normal Probability Plots
library(ggplot2)

#From video
ggplot(warpbreaks, aes(sample = breaks)) + geom_qq()
#output: a pretty straight line = normally distributed

  #sanity check w/ histogram
ggplot(warpbreaks, aes(x = breaks)) + geom_histogram()
#output: a bell curve = normally distributed


#From lesson
  #create normal prob. plot for Old Faithful data
ggplot(faithful, aes(sample = eruptions)) + geom_qq()
#output: an s curve != normally distributed

  #sanity check w/ histogram
ggplot(faithful, aes(x = eruptions)) + geom_histogram()
#output: two peaks, aka: bimodal != normally distributed


  #create normal prob. plot for Morley data
ggplot(morley, aes(sample = Speed)) + geom_qq()
#output: a pretty straight line = normally distributed

  #sanity check w/ histogram
ggplot(morley, aes(x = Speed)) + geom_histogram()
#output: a bell curve = normally distributed