#DSO102 - Statistical Programming in R
  #Lesson 7 - t-Tests
  #Page 2 - Single Sample t-Tests

#load relevant packages
library(ggplot2)
library(dplyr)


#From video

#Sample t-Test: Testing the mean of a single population
  #Based on a sample, is the mean of a population equal to a 
  #value or not equal to a value?

#create dataset to match video
  #create vectors
Division <- c(1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9)
OfficerYN <- c(1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0)
Total_Soldiers <- c(708,9314,941,11943,815,11109,805,11704,
                    1019,14536,562,9277,533,8056,587,10914,
                    95,2451)
Killed<- c(42,624,66,731,50,543,28,337,2,25,33,336,18,186,5,
           86,2,41)
Wounded <- c(262,2969,270,2924,251,2778,129,1482,14,171,120,
            1802,43,769,39,315,15,172)
Captured_Missing <- c(83,2079,13,365,14,575,1,210,0,30,62,1448,
                     2,64,8,399,0,12)
NonCasualty <- c(321,3642,592,7923,500,7213,647,9675,1003,
                 14310,347,5691,470,7037,535,10114,78,2226)
#output (for all): 7 new vectors created
  
  #assign vectors to new data frame
Gettysburg_Soldiers <- data.frame(Division,OfficerYN,
                                  Total_Soldiers,Killed,
                                  Wounded,Captured_Missing,
                                  NonCasualty)
#output: new data frame created

#find out if there was a % difference between officers and
  #enlisted soldiers who were killed at Gettysburg
#create dataset with only officers
Gettysburg <- filter(Gettysburg_Soldiers, OfficerYN == "1")
#output: new data frame created which only includes
  #observations with officers

#find % of officers who were killed - creating a new data
  #frame which includes all the data from Gettysburg data
  #frame (officers only) + a new column for % killed
Gettysburg2 <- mutate(Gettysburg, PercentKilled = (
  Killed /Total_Soldiers) * 100)
#output: new data frame created which only includes
  #observations with officers and includes a new variable to
  #indicate the % who were killed

#find % of all soldiers who were killed - creating a new data
  #frame which includes all the data from the original data
  #frame + a new column for % killed
Gettysburg3 <- mutate(Gettysburg_Soldiers, PercentKilled = (
  Killed /Total_Soldiers) * 100)
#output: new data frame created which only includes a new 
  #variable to indicate the % of soldiers who were killed

#find the average % of all soldiers killed
Gettysburg4 <- Gettysburg3 %>% summarise(
  MeanTotal = mean(PercentKilled))
#output: new data frame with a single cell that has the
  #average % of soldiers killed: 3.56%

#conduct single sample t-test
GettysburgT <- t.test(Gettysburg2$PercentKilled, mu = 3.56)
GettysburgT
#output: data frame with t-test statistics created, then
    #printed on console
  #test is not significant (p > 0.05)
    #H0 accepted, H1 rejected
  #3.88% of officers were killed
  #translates to: officers were just as likely to risk their
    #lives as enlisted soldiers

#create a histogram to sanity check results
ggplot(Gettysburg2, aes(x=PercentKilled)) +
  geom_histogram(binwidth = 2)
#rough approximation of bell curve

#create a normal probability plot to further confirm
ggplot(Gettysburg2, aes(sample=PercentKilled)) + geom_qq()
#roughly straight line
  #can safely say you met assumptions for single sample
    #t-test, and your results are valid


#From lesson

#import dataset as data frame
frostedFlakes <- read.csv("/Users/hannah/Library/CloudStorage/GoogleDrive-gracesnouveaux@gmail.com/My Drive/Bethel Tech/Data Science/DSO102 Statistical Programming in R/Lesson 7: t-Tests/frostedflakes.csv")
#output: new frostedFlakes data frame with 2 variables
  #Lab, which contains the percentage of sugar measured in a 
    #25 gram sample of Frosted Flakes using a laboratory high 
    #performance liquid chromatography technique, and 
  #IA400, which contains the percentage of sugar in the same 
    #sample measured by a machine (the Infra-Analyzer 400).

#view first 6 lines of new data frame
head(frostedFlakes)
#output: first 6 lines of new data frame printed in console

#According to the nutritional information supplied with 
  #Frosted Flakes, the sugar percentage by weight is 37%
  #You will create a hypothesis test to see if the data set 
  #provides evidence to the contrary. To set up the 
  #hypothesis test, define the null and alternate hypotheses 
  #as follows:
    #H0: mu = 37
    #H1: mu != 37

#use a t-test to see which hypothesis to accept
frostedFlakesT <- t.test(frostedFlakes$Lab, mu =37)
print(frostedFlakesT)
#output: data frame with t-test statistics created, then
    #printed on console
  #test is significant (p < 0.05)
    #H0 rejected, H1 accepted
  #Frosted Flakes contain 37.6% of sugar by weight, based on
    #measurements from the lab

#create and decorate a histogram
frostedFlakesHistog <- ggplot(frostedFlakes, aes(x = Lab))
frostedFlakesHistog + geom_histogram(binwidth = 1) +
  geom_vline(xintercept = frostedFlakesT$conf.int[1], 
             color = "red") +
  geom_vline(xintercept = frostedFlakesT$conf.int[2], 
             color = "red") +
  geom_vline(xintercept = frostedFlakesT$null.value, 
             color = "green")
#output: a beautiful bell curve! it has red lines on the 
    #upper and lower confidence intervals and a green line on
    #the mean
  #this satisfies the requirements for a t-test since the
    #data are normally distributed
  #this validates the results from the t-test b/c the mean
    #is outside those confidence intervals

#sanity check with a normal probability plot
ggplot(frostedFlakes, aes(sample = Lab)) + geom_qq()
#output: a plot with a roughly straight line, further
  #validating that the data are normally distributed


#From quiz: Google gives the level of Lake Huron as 577 feet 
  #above sea level. You want to test whether the data in the 
  #built-in dataset LakeHuron provides evidence that this is 
  #the correct lake level. Create a t-test to do this. What 
  #is the null hypothesis for this test?
    #H0: mu = 577
    #H1: mu != 577

#view dataset in console
LakeHuron
#output: console printed data.. unfamiliarly...

#create t-test for this dataset
t.test(LakeHuron$Value, mu =577)
#output: Error in LakeHuron$Value : $ operator is invalid 
    #for atomic vectors
  #atomic vector?! Time to Google...

#attempt to create a data frame from that dataset
lakeHuron <- data.frame(LakeHuron)
#output: success - phew! created a new lakeHuron data frame
  #with a single LakeHuron column/ variable/ factor
  #Realizing I don't know when to use which vocabulary
    #column, factor, variable
    #row, level, observation

#try again to create a t-test (attempting to leave out the
  # $column-name part of the argument, since there's only 1)
t.test(lakeHuron, mu = 577)
#output: success! console printed t-test data
  #One Sample t-test
  #data:  lakeHuron
  #t = 15.049, df = 97, p-value < 2.2e-16
  #alternative hypothesis: true mean is not equal to 577
  #95 percent confidence interval:
  # 578.7398 579.2684
  #sample estimates:
  #mean of x 
  # 579.0041 
#test is significant (p < 0.05)
  #H0 rejected, H1 accepted
  #data shows that Lake Huron is ~579' above sea level

#create a data frame (?!?) to hold the t-test statistics
lakeHuronT <- t.test(lakeHuron, mu = 577)
#output: well.. it did save.. but not sure what this holder
  #type is called - will ask in a future call

#create a histogram to validate findings
lakeHuronHistog <- ggplot(lakeHuron, aes(x = LakeHuron))
lakeHuronHistog + geom_histogram(binwidth = 1) +
  geom_vline(xintercept = lakeHuronT$conf.int[1], 
             color = "#fa229d") +
  geom_vline(xintercept = lakeHuronT$conf.int[2], 
             color = "#fa229d") +
  geom_vline(xintercept = lakeHuronT$null.value, 
             color = "#22faea")
#output: pretty much a bell curve... it has pink lines on the 
    #upper and lower confidence intervals and an aqua line on
    #the mean
  #this satisfies the requirements for a t-test since the
    #data are normally distributed
  #this validates the results from the t-test b/c the mean
    #is outside those confidence intervals

#sanity check with a normal probability plot
ggplot(lakeHuron, aes(sample = LakeHuron)) + geom_qq()
#output: a plot with a roughly straight line, further
  #validating that the data are normally distributed



#Page 3 - Independent t-Tests

#load relevant packages
library(ggplot2)
library(dplyr)


#From video

#Independent t-test: Testing the mean of two populations
  #Based on two samples, are the means of two populations equal 
  #to each other?

#find out if there was a % difference between officers and
  #enlisted soldiers who were wounded at Gettysburg

#find % of all soldiers who were wounded - creating a new data
  #frame which includes all the data from the original data
  #frame + a new column for % wounded
Gettysburg5 <- mutate(Gettysburg_Soldiers, PercentWounded = (
  Wounded /Total_Soldiers) * 100)
#output: new data frame created which only includes a new 
  #variable to indicate the % of soldiers who were wounded

#create 2 new data frames based on one above, one for officers
  #only, and one for enlisted soldiers only
Gettysburg6 <- filter(Gettysburg5, OfficerYN == "1")
Gettysburg7 <- filter(Gettysburg5, OfficerYN == "0")
#output: 2 new data frames, as noted above

#create independent t-test
GettysburgTInd <- t.test(Gettysburg6$PercentWounded, 
                         Gettysburg7$PercentWounded, 
                         alternative = "two.sided",
                         var.equal = FALSE)
GettysburgTInd
#output: data frame with t-test statistics created, then
    #printed on console
  #test is not significant (p > 0.05)
    #H0 accepted, H1 rejected
  #18.42% of officers were wounded
    #14.9% of enlisted soldiers were wounded
  #translates to: officers were fighting alongside the
    #enlisted soldiers

#create a histogram for each data frame to sanity check results
ggplot(Gettysburg6, aes(x = PercentWounded)) +
  geom_histogram(binwidth = 10)
#output: a perfect bell curve
  #the officer data are exactly normally distributed

ggplot(Gettysburg7, aes(x = PercentWounded)) +
  geom_histogram(binwidth = 14)
#output: roughly a bell curve
  #the enlisted soldier data are also normally distributed
  #assumptions/ requirements are met for the independent
   #t-test


#From lesson

#Suppose you now want to determine if the measurements made by 
    #the IA-400 give us the same average values as the lab 
    #measurements. To do this, you will think of the 
    #measurements in the data set as coming from two 
    #populations: one population is the lab measurements, and 
    #the other is the IA-400 measurements.
  #Define the null and alternative hypotheses as follows:
    #H0: mu1 = mu2
    #H1: mu1 != mu2

#use a t-test to see which hypothesis to accept
frostedFlakesTInd <- t.test(frostedFlakes$Lab, 
                            frostedFlakes$IA400,
                            alternative = "two.sided",
                            var.equal = FALSE)
print(frostedFlakesTInd)
#output: data frame with t-test statistics created, then
    #printed on console
  #test is not significant (p > 0.05)
    #H0 accepted, H1 rejected
  #Frosted Flakes contain 37.6% of sugar by weight, based on
      #measurements from the lab
    #Frosted Flakes contain 38.22% of sugar by weight, based on
      #measurements from the IA-400 machine

#create a box plot to sanity check results
  #first step is to create a new data frame with all data in 
  #a single column

#install a new package to learn and use this new step and
  #enable it
install.packages("reshape2")
library(reshape2)

#create new data frame
frostedFlakesMelted <- melt(frostedFlakes, id = "X")
#output: new data frame with Lab and IA-400 in a single 
  #column

#create box plot
ggplot(frostedFlakesMelted) + 
  geom_boxplot(aes(x = variable, y = value)) +
  xlab("Test Method") + ylab("Percentage of Sugar")
#output: side by side box plot - with this lesson analysis:
  #As you can see from this plot, the IA400 group has a 
  #somewhat different median value than the Lab group, and 
  #the IA400 group has a larger variation as evidenced by the 
  #longer whiskers and the larger box. However, there is not 
  #a large difference in the median values. So it makes sense 
  #that the t-test would not indicate that there is strong 
  #evidence that the two means are different


#From quiz
  #The DAAG package has data on the levels of several Great 
  #Lakes; this data is in the greatLakes dataset. Suppose 
  #you want to know whether Lake Erie or Lake Huron has the 
  #higher level. You can set up a hypothesis test to do this 
  #as follows. 
    #First, load the DAAG package with library(DAAG)
    #Then create two vectors with these commands: 
      #erie <- greatLakes[,1]
      #huron <- greatLakes[,2]
    #Use these vectors to create a hypothesis test to 
      #determine whether the two lake levels are equal. 
  #What is the null hypothesis for this test?
    #H0: mu1 = mu2
    #H1: mu != mu2

#First, load the DAAG package with library(DAAG)
install.packages("DAAG")
library(DAAG)
#output: package installed and loaded

#Then create two vectors with these commands: 
erie <- greatLakes[,1]
huron <- greatLakes[,2]
#output: 2 new vectors created, each with 92 elements (per
  #index)

#create data frame with new vectrs
greatLakesEH <- data.frame(erie, huron)
#output: a new data frame

#Use these vectors to create a hypothesis test to determine 
  #whether the two lake levels are equal.
greatLakesTInd <- t.test(greatLakesEH$erie,
                         greatLakesEH$huron,
                         alternative = "two.sided",
                         var.equal = FALSE)
greatLakesTInd
#output: data frame with t-test statistics created, then
    #printed on console
  #test is significant (p < 0.05)
    #H0 rejected, H1 accepted
  #Lake Erie has a level of 174.14
    #Lake Huron has a level of 176.43



#Page 4 - Dependent t-Tests

#load relevant packages
library(ggplot2)
library(dplyr)


#From video

#Dependent t-test: Testing the mean of two populations
#Based on two samples, where each observation in one sample is 
#related to a specific observation in the other sample, are 
#the means of the two populations equal to each other?

#create dataset to match video
#create vectors
LineDryLengthShrinkage <- c(5.4,5.4,2.8,3,7,7.2,4.2,4.5,7.5,
                            7.9,4.8,5.2)
DryerLengthShrinkage <- c(6.8,6.5,2.9,3.6,7.9,8,4,4.8,8.6,
                          8.8,4.7,5.3)
LineDryWidthShrinkage <- c(6.1,6.4,2.3,2.5,6.5,6.9,3,3.3,
                           6.7,7.1,3.2,3.4)
DryerWidthShrinkage <- c(6.8,7.3,2.2,2.6,7.3,7.8,2.8,3,7,
                         7.6,3.1,3.5)
#output (for all): 4 new vectors created

#assign vectors to new data frame
laundry <- data.frame(LineDryLengthShrinkage,
                      DryerLengthShrinkage,
                      LineDryWidthShrinkage,
                      DryerWidthShrinkage)
#output: new data frame created


#find difference in shrinkage for laundry that is dried on a
#line vs. in a dryer
#H0: mu2 - mu1 = 0
#H1: mu2 - mu1 != 0

#dependent t-test for length shrinkage
laundryTLength <- t.test(laundry$LineDryLengthShrinkage,
                         laundry$DryerLengthShrinkage,
                         paired = TRUE)
laundryTLength
#output: data frame with t-test statistics created, then
#printed on console
#test is significant (p: 0.002839 < 0.05)
#H0 rejected, H1 accepted
#Avg. dryer length shrinkage - avg. line length shrinkage: 
#-0.58
#translates to: dryers cause more length shrinkage than 
#lines

#To see which shrunk lengths more, compare means
mean(laundry$LineDryLengthShrinkage)
#output: 5.41

mean(laundry$DryerLengthShrinkage)
#output: 5.99
#validates that dryers cause more length shrinkage than lines


#dependent t-test for width shrinkage
laundryTWidth <- t.test(laundry$LineDryWidthShrinkage,
                        laundry$DryerWidthShrinkage,
                        paired = TRUE)
laundryTWidth
#output: data frame with t-test statistics created, then
    #printed on console
  #test is significant (p: 0.03956 < 0.05)
    #H0 rejected, H1 accepted
  #Avg. dryer width shrinkage - avg. line width shrinkage: 
    #-0.3
  #translates to: dryers cause more width shrinkage than 
    #lines

#To see which shrunk widths more, compare means
mean(laundry$LineDryWidthShrinkage)
#output: 4.783333

mean(laundry$DryerWidthShrinkage)
#output: 5.083333
#validates that dryers cause more width shrinkage than lines

#overall outcome: fabric shrinks more in the dryer than when
  #line dried


#From lesson
#An instructor is required to find out how much students 
  #learn in her course. At the beginning of the course, she 
  #randomly selects a group of students in her course, and 
  #gives each student in this group a pre-test over the class 
  #material and records their scores. At the end of the 
  #course, she gives each student in the group the same test 
  #as a post-test. She wants to see if the difference in 
  #scores is statistically significant; in other words, she 
  #wants to see if, on average, each student's scores 
  #improved.
    #H0: mu2 - mu1 = 0
    #H1: mu2 - mu1 != 0

#upload dataset
scores <-  read.csv("/Users/hannah/Library/CloudStorage/GoogleDrive-gracesnouveaux@gmail.com/My Drive/Bethel Tech/Data Science/DSO102 Statistical Programming in R/Lesson 7: t-Tests/scores.csv")
#output: new scores data frame

#view beginning of dataset
head(scores)
#output: first 6 lines printed in console

#dependent t-test for test differences
scoresTDep <- t.test(scores$pretest, scores$postest,
                     paired = TRUE)
scoresTDep
#output: data frame with t-test statistics created, then
    #printed on console
  #test is significant (p: < 2.2e-16 < 0.05)
    #H0 rejected, H1 accepted
  #Avg. post-course test score - avg. pre-course test score: 
    #-8.32
  #translates to: test scores improved after the course

#To see average scores for pre- and post-course tests
mean(scores$pretest)
#output: 11.6

mean(scores$postest)
#output: 19.94
#validates that test scores improved after the course

#overall outcome: test scores improved after the course

#graph the data to further validate test results
  #load the package for blending data
library(reshape2)
#output: package loaded

  #blend the data
blendedScores <- melt(scores, measure.vars = 
                        c("pretest","postest"))
#output: new data frame with pretest and postest in a single
  #column

  #create box plot to validate the results
ggplot(blendedScores) + geom_boxplot(aes(x = variable,
                                         y = value)) +
  xlab("Test") +
  ylab("Score")
#output: side by side box plot which shows the post-course
  #test scores were higher than pre-course test scores
  #validates results above

  #create histogram to validate the results

    #create new data frame of difference in test scores
      #pre- and post-course
scoresDiff <- scores$postest - scores$pretest
#output: new vector with difference in score per student

    #create new data frame with score diff. data
scoresDiffFrame <- data.frame(scoresDiff)
#output: single column data frame with score differences

    #create histogram
ggplot(scoresDiffFrame, aes(x = scoresDiff)) +
  geom_histogram(binwidth = 1) +
  xlab("Difference between pre- and post- test scores")
#validates results above
#From lesson: From this histogram of differences, you can see 
  #that the post-test score for most students was between 5 
  #and 13 points higher than the pretest score.



#Page 6 - Workshop

#load dataset
EmployeeAttrition <- read.csv("/Users/hannah/Library/CloudStorage/GoogleDrive-gracesnouveaux@gmail.com/My Drive/Bethel Tech/Data Science/DSO102 Statistical Programming in R/Lesson 7: t-Tests/ibmAttrition.csv")
#output: new data frame from dataset

#view beginning of data
head(EmployeeAttrition)
#output: first 6 lines of each column printed in console

#b/c first 6 row printing was a little awkard, view data frame
View(EmployeeAttrition)
#output: data frame opens in new tab


#Single sample
  #Does distance from home differ from a (population) mean of 
      #27 miles?
    #H0: mu = 27
    #H1: mu != 27

#create t-test to test hypotheses
ibmTSs <- t.test(EmployeeAttrition$DistanceFromHome, mu = 27)
ibmTSs
#output: data frame with t-test statistics created, then
    #printed on console
  #test is significant (p: < 2.2e-16 < 0.05)
    #H0 rejected, H1 accepted
  #The average distance from home is 9.19 miles


#Independent t-test
  #Does the distance from home differ between former and current
      #employees?
    #H0: mu1 = mu2
    #H1: mu1 != mu2

#create independent t-test
  #note: formula (?) is pretty different from page 3 of lesson,
    #I think this is due to categorical vs. continuous data ?!?
ibmTInd <- t.test(EmployeeAttrition$DistanceFromHome ~ 
                    EmployeeAttrition$Attrition)
ibmTInd
#output: data frame with t-test statistics created, then
    #printed on console
  #test is significant (p: 0.004137 < 0.05)
    #H0 rejected, H1 accepted
  #The avg. distance from home for former employees is 10.63 
    #mi's
  #The avg. distance from home for current employees is 8.92 
    #mi's
  #There is a significant difference in distance from home for
    #current and former employees


#Dependent t-test
  #Does your salary increase over time?
    #H0: mu2 - mu1 = 0
    #H1: mu2 - mu1 != 0

#Create a new data frame
  #Create vectors
ibmName <- c("Bob","Bob","Cyrus","Cyrus","Randy","Randy",
             "James", "James")
ibmSalary <- c(12000,75000,56000,83000,12000,25000,46000,72000)
ibmYear <- c("2010","2020","2010","2020","2010","2020","2010",
             "2020")
#output (for all): vectors created

  #Create data frame
ibmSalaries <- data.frame(ibmName,ibmSalary,ibmYear)
#output: new data frame with selected vectors

#create dependent t-test
ibmTDep <- t.test(ibmSalaries$ibmSalary ~ ibmSalaries$ibmYear,
                  paired = TRUE)
ibmTDep
#output: data frame with t-test statistics created, then
    #printed on console
  #test is significant (p: 0.05747 > 0.05) <- difference is 
      #small and data shows that there is an increase
    #H0 rejected, H1 accepted
  #Avg. salary for last year - avg. salary for first year: 
    #-32250 translates to: salary does increase over time


#Dependent t-test from vectors instead of data frame
ibmTDepVec <- t.test(ibmSalary ~ ibmYear, paired = TRUE)
ibmTDepVec
#output: data frame with t-test statistics created, then
    #printed on console
  #test is significant (p: 0.05747 > 0.05) <- difference is 
    #small and data shows that there is an increase
  #H0 rejected, H1 accepted
  #Avg. salary for last year - avg. salary for first year: 
    #-32250 translates to: salary does increase over time
  #NOTE: all this is identical to dependent t-test above, per
    #using the same actual data