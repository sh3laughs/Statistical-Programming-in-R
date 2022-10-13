#DSO102 - Statistical Programming in R
  #Lesson 10 - Final Project Workshop

#load potentially relevant packages
library(addinexamples)
library(dplyr)
library(ggplot2)


#import data (used button)
  #NOTE: I had to check the "Strings as factors" box!)

#View data
View(top10s)
#output: data opened in new tab, it has: 603 entries, 
  #15 total columns

#see data range for data
unique(top10s$year)
#output: indexed year values printed in console
  #Data are from 2010- 2019


#Create box plot of energy rating by genre
ggplot(top10s, aes(x = top_genre, y = nrgy)) +
  geom_boxplot()
#output: side by side box plot that's pretty hard to read
  #x axis is illegible


#Which genres have the highest energy ratings and which
  #have the lowest

  #lowest
top10s %>% group_by(top_genre) %>% 
  summarise(nrgyMn = mean(nrgy)) %>% 
  arrange(nrgyMn)
#output: first 10 of 50 row tibble printed in console
  #genre w/ lowest energy rating: alaska indie at 34

  #highest
top10s %>% group_by(top_genre) %>% 
  summarise(nrgyMn = mean(nrgy)) %>% 
  arrange(desc(nrgyMn))
#output: first 10 of 50 row tibble printed in console
    #genre w/ highest energy rating: french indie pop at 89
  #Alaska indie is the slowest music from this data and
    #French indie pop is the fastest


#Find the median energy rating for all genres for each 
  #year
top10sMed <- top10s %>% group_by(year) %>% 
  summarise(nrgyMed = median(nrgy))
#output: saved and first 10 of 50 row tibble printed in 
  #console

#Plot the median for the years 2010-2019
  #Note this date range is full data and can be ignored
ggplot(top10sMed, aes(x = year, y = nrgyMed)) +
  geom_point()
#output: scatter plot shows data are strongly and 
  #negatively correlated - as dates go up (more recent),
  #median energy goes down noticeably

#Create a scatter plot of energy level vs danceability
ggplot(top10s, aes(x = nrgy, y = dnce)) +
  geom_point() + geom_smooth(method = lm)
#output: scatter plot shows data are not very correlated 

#Are energy level and danceability correlated?
cor.test(top10s$nrgy, top10s$dnce, method = "pearson",
         use = "complete.obs")
#output: test statistics printed in console
  #test is significant (p: 3.682e-05 < 0.05)
    #H0 rejected, H1 accepted
  #cor: 0.17 - weak
  #Correlation is weak but positive and significant

#Update scatter plot to represent years with colors
ggplot(top10s, aes(x = nrgy, y = dnce, color = year)) +
  geom_point() + geom_smooth(method = lm)
#output: scatter plot shows data are not very correlated,
  #this does show that older music was slower and less
  #danceable

#Do a linear regression
top10sReg <- lm(dnce ~ nrgy, top10s)
summary(top10sReg)
#output: test statistics printed in console
  #test is significant (p: 3.682e-05 < 0.05)
    #H0 rejected, H1 accepted
  #m: 0.13715
  #b: 54.70998
  #adjusted R2: 0.02634 (2.63% variance)

#How much variability does the above line explain?
  #2.63%

#Convert duration to minutes, then graph to see how it
  #relates to speech
top10sDurMin <- top10s %>% mutate(min = dur / 60)
top10sDurMin
#output: data saved and printed in console, with a new
  #min column that has the duration conversion (from
  #seconds)

ggplot(top10sDurMin, aes(x = min, y = spch)) +
  geom_point()
#output: funny little scatter plot - most songs are
  #shorter with less words

#Create a new data frame with just rows from 2010
top10s2010 <- top10s %>% filter(year == 2010)
#output: data saved - 51 observations (per index in
  #environment)

#Create a new data frame with just rows from 2019
top10s2019 <- top10s %>% filter(year == 2019)
#output: data saved - 31 observations (per index in
  #environment)

#Reduce observations for 2010 so that data sets for 
  #t-test have the same number of observations each
top10s2010Sub <- top10s2010[1:31,]
#output: subset saved

#Use paired t-test to see if the amount of speech has
  #changed over time
t.test(top10s2010Sub$spch, top10s2019$spch, 
       paired = TRUE)
#output: test statistics printed in console
  #test is significant (p: 0.684 > 0.05)
    #H0 accepted, H1 rejected
  #speech hasn't changed over time