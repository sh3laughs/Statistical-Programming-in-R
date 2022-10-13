#DSO102 - Statistical Programming in R
#Lesson 8 - Linear Regression

  #Page 1 - Overview

#load relevant packages
library(ggplot2)
library(dplyr)


#From Workshop

#Confirm if I have dataset already
head(USArrests)
#output: I do! First 6 lines printed in console

#Preview data
View(USArrests)
#output: data frame opened in new tab

#compute simple linear regression test
  #H0: IV has no impact on DV
  #H1: IV has an impact on DV
usArrestsLm <- lm(Assault ~ UrbanPop, USArrests)
summary(usArrestsLm)
#output: a new data frame with *TEST* statistics created, 
    #then printed on console
  #test is not significant (p: 0.06948 < 0.05)
    #H0 accepted, H1 rejected
  #translates to: population changes do not impact the
    #number of assaults

#create a graph to validate results
usArrestsGraph <- ggplot(USArrests, aes(x = UrbanPop, 
                                        y = Assault)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)
usArrestsGraph
#output: a new data frame created with scatterplot, then
  #printed on plots pane
#validates results above - the data is all over the place



  #Page 2 - Scatter Plots

#load relevant packages
library(ggplot2)
library(dplyr)


#From Video

#attempt to import same dataset
library(readxl)
read_excel("/Users/hannah/Library/CloudStorage/GoogleDrive-gracesnouveaux@gmail.com/My Drive/Bethel Tech/Data Science/DSO102 Statistical Programming in R/Lesson 8: Linear Regression/highway_rail_accidents_2016.xls")
#wrong dataset and not usable

#settling for one that's different but closer to video's
train_accidents <- read.csv("/Users/hannah/Library/CloudStorage/GoogleDrive-gracesnouveaux@gmail.com/My Drive/Bethel Tech/Data Science/DSO102 Statistical Programming in R/Lesson 8: Linear Regression/train_accidents.csv")
View(train_accidents)
#output: new data frame created and opened in new tab

#create a scatter plot
ggplot(train_accidents, aes(x = STCNTY, y = EVENT)) +
  geom_point() +
  xlab("Amount of Damage in Dollars")+
  ylab("Speed (mph)")
#output: a disaster... this dataset sucks and is WAY too big

#remove sucky dataset
remove(train_accidents)
#output: all the R world rejoiced, personally I'm frustrated
  #that the videos include data we can't play along with
  #usually I'm good at replicating, finding online, or 
  #finding one that at least is close enough.. not this time


#From lesson

#create a scatter plot for Old Faithful's eruption times vs.
  #waiting times
oldFaithErupScatt <- ggplot(faithful, aes(x = eruptions, 
                                          y = waiting))
oldFaithErupScatt + geom_point()
#output: scatter plot (phew.. was nervous after video fiasco)

#add labels to the scatter plot
oldFaithErupScatt + geom_point() +
  ggtitle("Old Faithful Eruption vs. Waiting Times") +
  xlab("Eruption Time (min)") +
  ylab("Waiting Time (min)")
#output: labeled scatter plot

#add a line to the scatter plot
oldFaithErupScatt + geom_point() +
  ggtitle("Old Faithful Eruption vs. Waiting Times") +
  xlab("Eruption Time (min)") +
  ylab("Waiting Time (min)") +
  geom_smooth(method = lm)
#output: labeled scatter plot with line
  #grey confidence region (shading on either side of line)
  #indicates that confidence decreases on both ends

#remove confidence region
oldFaithErupScatt + geom_point() +
  ggtitle("Old Faithful Eruption vs. Waiting Times") +
  xlab("Eruption Time (min)") +
  ylab("Waiting Time (min)") +
  geom_smooth(method = lm, se = FALSE)
#output: labeled scatter plot with line (and no confidence
  #region)

#change colors
oldFaithErupScatt + geom_point() +
  ggtitle("Old Faithful Eruption vs. Waiting Times") +
  xlab("Eruption Time (min)") +
  ylab("Waiting Time (min)") +
  geom_smooth(method = lm, se = FALSE, color = "goldenrod2")
#output: found a bug (really just something missing) in the
  #lesson - this only affected line (as expected)

#change color of dots, too - attempt 1
oldFaithErupScatt + geom_point(color = "red") +
  ggtitle("Old Faithful Eruption vs. Waiting Times") +
  xlab("Eruption Time (min)") +
  ylab("Waiting Time (min)") +
  geom_smooth(method = lm, se = FALSE, color = "goldenrod2")
#output: success! red dots



  #Page 3 - Correlation Basics

#load relevant packages
library(ggplot2)
library(dplyr)


#From lesson
#You will next create a plot that indicates very little 
  #correlation
  #The USArrests data frame has gruesome statistics on 
    #arrests for violent crimes, in arrests per 100,000 
    #residents, in each of the 50 US states in 1973. One of 
    #the variables in this data frame is Murder, which is 
    #the murder rate for each state. Another variable is 
    #UrbanPop, which is the percentage of the state's 
    #population that lives in an urban area. You can create 
    #a scatter plot of these two variables together with 
    #the linear regression line
usArrestsMurdScatt <- ggplot(USArrests, aes(x = UrbanPop,
                                            y = Murder))
usArrestsMurdScatt + geom_point() + geom_smooth(method = lm,
                                                se = FALSE)
#output: scatter plot with line
  #data are very weakly correlated (as noted above)

#You now can make a plot that shows a negative correlation
  #The data frame mtcars has data from the 1974 Motor Trend 
  #magazine; this data covers 32 1973–74 models. One 
  #variable in this data frame is mpg, which is the car's 
  #mileage in miles per US Gallon of fuel. Another variable 
  #is disp, the engine displacement in cubic inches. You can 
  #create a scatter plot of these two variables with the 
  #linear regression line
mtcarsScatt <- ggplot(mtcars, aes(x = disp, y = mpg))
mtcarsScatt +  geom_point() + geom_smooth(method = lm, 
                                          se = FALSE)
#output: negative correlated scatter plot
  #It also looks to be only moderately strong, but I have
  #no r value to confirm that



#Page 4 - Calculating Correlation

#load relevant packages
library(ggplot2)
library(dplyr)


#From video (can't do much per not being an accessible or 
  #replicatable dataset)
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

install.packages("corrplot")
library(corrplot)


#From lesson

#create a correlation test
cor.test(mtcars$hp, mtcars$cyl, method = "pearson",
         use = "complete.obx")
#output: correlation test statistics printed in console
    #p: 3.478e-09
    #cor: 0.8324475
  #test is significant (p: 3.478e-09 < 0.05)
    #H0 rejected, H1 accepted
  #Correlation coefficient (r value): Strong (0.7 - 1.0)
  #The relationship between horsepower and # of 
    #cylinders is strongly and significantly correlated

#create a correlation matrix - part 1 using 
  #chart.Correlation

#create a new data frame with only continuous variables 
  #from mtcars dataset
mtcarsCont <- mtcars[,c(1:7)]
#output: new data frame created with select columns

#create a correlation matrix
chart.Correlation(mtcarsCont, histogram = FALSE, 
                  method = "pearson")

#create a correlation matrix - part 2 using corrplot

#create and view a correlation matrix that can be 
  #saved for use with corrplot function
mtcarsMatrix <- cor(mtcarsCont)
mtcarsMatrix
#output: correlation matrix printed in console with 
  #all correlation values for the dataset

#create the matrix (lol)
corrplot(mtcarsMatrix, type = "upper", order = "hclust",
         p.mat = mtcarsMatrix, sig.level = 0.01, 
         insig="blank")
#output: a pretty corrplot :)
#Data that has any correlation is negatively 
  #correlated (per being red)


#From link included in lesson: https://www.sthda.com/english/wiki/visualize-correlation-matrix-using-correlogram

#Playing with method argument
corrplot(mtcarsMatrix, method = "circle")
corrplot(mtcarsMatrix, method = "color")
corrplot(mtcarsMatrix, method = "ellipse")
corrplot(mtcarsMatrix, method = "number")
corrplot(mtcarsMatrix, method = "pie")
corrplot(mtcarsMatrix, method = "shade")
corrplot(mtcarsMatrix, method = "square")
#output (for all): corrplot matrix with different styles
  #of representation for the data

#Playing with color spectrum
colorPalette <- colorRampPalette(c("#43eeab", "white", 
                                   "pink"))
corrplot(mtcarsMatrix, col = colorPalette)
#output: absolutely adorable corrplot <3

#Playing with background color
corrplot(mtcarsMatrix, bg = "light blue")
#output: corrplot with colored background

#Playing with labels
corrplot(mtcarsMatrix, tl.col = "blue", tl.srt = 45)
#output: blue labels and top labels slanted




#Page 6 - Computing Linear Regression

#load relevant packages
library(ggplot2)
library(dplyr)


#From video - typing out her code, though I don't have
#the dataset

#linear regression test
TrainRegression <- lm(EqpDamg ~ Speed, train_accidents)
summary(TrainRegression)
#Her output is the test statistics
  #Noteworthy: R-squared value is 0.576 which means that
    #speed accounts for ~6% of the variance in train
    #accident damage costs - which also means that ~94%
    #of the variance is missing from this data

#using data from linear regression test in formula
y = mx + b
y = (3324.7 * 15) + 29613.2
y
#output: 79483.7
  #A train wrecking at 15 mph will typically cause
  # $79,483.70 worth of damage


#From lesson
#preview dataset
head(cars)
#output: first 6 lines printed in console

#linear regression test on the dataset - asking R to 
  #produce a line showing stopping distance by speed
carsLinReg <- lm(dist ~ speed, cars)
carsLinReg
#output: test statistics printed in console:
  #Coefficients:
  #(Intercept)        speed  
  #    -17.579        3.932

#Just for fun
#Using those stat's in formula: y = mx + b for first speed
y = (3.932 * 4) + (-17.579)
y
#output: -1.851
  #A car moving a 4 mph has a stopping distance of -1.86'
    #Not sure what this negative value implies...
    #Negative correlation??
  #UPDATE: confirmed that the value is absolute, so the 
    #stopping distance is 1.86' and the data are negatively 
    #correlated

#view more test statistics from same test
summary(carsLinReg)
#output: test stat's summary printed on console
  #test is significant (p: 1.49e-12 < 0.05)
    #H0 rejected, H1 accepted

#Using those stat's in formula: y = mx + b for another
  #speed from the dataset, this time b/c the lesson
  # called for it (I jumped the gun above!)
y = (3.932 * 21) + (-17.579)
y
#output: 64.993
  #A car moving a 21 mph has a stopping distance of 64.99'

#Using those stat's in formula: y = mx + b for another
  #speed, note in the dataset
y = (3.932 * 45) + (-17.579)
y
#output: 159.361
  #A car moving a 21 mph has a stopping distance of 
  #159.36'
#Note from lesson: Your regression model shows that it 
  #will take 159.36 feet to stop. However, you should be 
  #very hesitant to accept this number for the following 
  #reason: you have created the model using speeds 
  #between 4 and 25 miles per hour. There is no data to 
  #verify that your model will work well for speeds above 
  #25 miles per hour. In this case, you are using the 
  #model to extrapolate beyond the data, and 
  #extrapolation can be fraught with peril. In the case 
  #of the distance necessary to stop a car, this linear 
  #model may not be accurate at higher speeds.

#create a scatter plot with a best fit line
carsScatt <- ggplot(cars, aes(x = speed, y = dist))
carsScatt + geom_point() + geom_smooth(method = lm,
                                       se = FALSE)
#output: scatter plot with a positive correlation best 
  #fit line which validates the results above


#From quiz - q2
y = mx + b
y = (-0.3285 * x) + 1.2828
y