#DSO102 - Statistical Programming in R
  #Lesson 8 - Linear Regression
  #Page 8 - Hands-On

#load relevant packages
library(ggplot2)


#...use the mtcars data frame to examine the effect that 
  #engine horsepower (hp) and vehicle weight (wt), 
  #measured in thousands of pounds) have on the time 
  #necessary to travel one quarter mile from a standing 
  #start (qsec)


#REQUIREMENT 1
  #Create a scatter plot with a trend line where the 
  #horizontal axis is engine horsepower and the vertical 
  #axis is quarter mile time.
mtcarsHpScatt <- ggplot(mtcars, aes(x = hp, y = qsec))
mtcarsHpScatt + geom_point() + 
  geom_smooth(method = lm, se = FALSE) +
  xlab("Engine Horsepower") +
  ylab("Quarter Mile Time (sec)") +
  ggtitle("Quarter Mile Time by Engine Horsepower")
#output: scatter plot with a best fit line indicating a
  #strong, negative correlation

#Q: What is the relationship between time and engine 
  #horsepower: positively correlated, negatively 
  #correlated, or uncorrelated?
#A: Quarter mile time and engine horsepower are
  #strongly and negatively correlated


#REQUIREMENT 2
  #Compute the linear regression for time and engine 
  #horsepower.
mtcarsHpReg <- lm(qsec ~ hp, mtcars)
summary(mtcarsHpReg)
#output: test statistics saved and printed in console
    #y-intercept: 20.556354
    #slope: -0.018458
    #Adjusted R-squared: 0.485 (49% of variance)
    #Overall p-value: 5.766e-06
  #test is significant (p: 5.766e-06 < 0.05)
    #H0 rejected, H1 accepted
  #data are strongly and negatively correlated

#Q1: What is the equation of the line?
#A1: y = (-0.018458 * x) - 20.556354

#Q2: What is the R-squared value? 
#A2: 0.485 (49%)

#Q3: Is this what you would expect?
#A3: No, actually I expected horsepower to have a 
  #positive correlation with quarter mile time
  #CORRECTED (after submission): yes, this is what I expected 
   #(was thinking Qsec going down meant slower, but it is faster, 
   #of course!)


#REQUIREMENT 3
#Create a scatter plot with a trend line where the 
  #horizontal axis is vehicle weight and the vertical 
  #axis is quarter mile time.
mtcarsWtScatt <- ggplot(mtcars, aes(x = wt, y = qsec))
mtcarsWtScatt + geom_point() + 
  geom_smooth(method = lm, se = FALSE) +
  xlab("Vehicle Weight (lb)") +
  ylab("Quarter Mile Time (sec)") +
  ggtitle("Quarter Mile Time by Vehicle Weight")
#output: scatter plot with a best fit line indicating a
  #moderate, negative correlation

#Q: What is this relationship: positively correlated, 
  #negatively correlated, or uncorrelated?
#A: Quarter mile time and vehicle weight are
  #moderately and negatively correlated 


#REQUIREMENT 4
#Compute the linear regression for these two variables
mtcarsWtReg <- lm(qsec ~ wt, mtcars)
summary(mtcarsWtReg)
#output: test statistics saved and printed in console
    #y-intercept: 18.8753
    #slope: -0.3191
    #Adjusted R-squared: -0.00179 (0.02% of variance)
      #CORRECTED (after submission): 0.00% of variance!
    #Overall p-value: 0.3389
  #test is significant (p: 0.3389 < 0.05)
    #H0 rejected, H1 accepted
  #data are moderately and negatively correlated

#Q1: What is the equation of the line?
#A1: y = (-0.3191 * x) - 18.8753

#Q2: What is the R-squared value? 
#A2: -0.00179 (0.02%)

#Q3: Is this what you would expect?
#A3: Sort of.. I actually expected weight to have a 
  #stronger impact than it did in this data
  #CORRECTED (after submission): Not really, I would have thought 
    #weight would have a bigger impact AND that it would slow down 
    #the quarter mile time