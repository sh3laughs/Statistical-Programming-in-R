#DSO102 - Statistical Programming in R
  #Lesson 7 - t-Tests
  #Page 6 - Hands-On

#load relevant packages
library(ggplot2)
library(dplyr)

#View dataset which gives the mean annual temperature in New Haven, 
  #CT, for the years 1912 to 1971
View(nhtemp)
head(nhtemp)
#output: opened data in a new tab - I'm unfamiliar with this type
  #of data, though we encountered it earlier in this lesson, I 
  #haven't been on a call yet since then to ask about it... it's 
  #different from the data frames we've been using b/c it is only
  #a single row the way we can preview it in separate tab and in
  #console

#Use a dependent t-test to confirm whether the average over the 
  #first 25 years (1912 to 1936) of the data is statistically 
  #significantly different than the average over the last 25 years 
  #(1947 to 1971)
    #H0: mu2 - mu1 = 0
    #H1: mu2 - mu1 != 0

#Create two vectors from the data set:
  #first25: temperatures recorded in 1912 to 1936
  #last25: temperatures recorded in 1947 to 1971
first25 <- nhtemp[1:25]
last25 <- nhtemp[36:60]
#output: two new vectors in environment, each with 25 elements
  #(per index info there)

#Compute a dependent t-test to see if these two vectors have the 
  #same mean
nhtempTDep <- t.test(last25, first25, paired = TRUE)
nhtempTDep
#output: data frame with t-test statistics created, then
    #printed on console
  #test is significant (p: 0.0006383 < 0.05)
    #H0 rejected, H1 accepted
  #Avg. temp in the last 25 years - avg. temp in the first 25 
    #years: 1.484
  #translates to: average temperatures were significantly higher in 
    #the last 25 years than they were in the first 25

#Validate translation by viewing both means
mean(first25)
mean(last25)
#output: mean of the first 25 years (50.42) is less than the mean
  #of the last 25 years (51.9)
  #this validates the results above