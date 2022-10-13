#DSO102 - Statistical Programming in R
  #Lesson 10 - Final Project

#load potentially relevant packages
library(dplyr)
library(ggplot2)

#NOTE: comments beginning with * are directly from the course
  #content for this project - ie: instructions and questions 
  #AND there are sections for each separate set of directions


# Initial requirements from course content --------------------------------------

#*For this Final Project, you will use the Cigarette data set 
  #in the Ecdat package. To do this, you first must install 
  #the Ecdat package with the command
install.packages("Ecdat")
#output: console confirmed this was successfully installed

#*To make this package accessible to your R session, type the 
  #command
library(Ecdat)
#output: package loaded

#*You should now be able to see the Cigarette data frame:
head(Cigarette)
#output: first 6 rows printed in console

#Key to variables:
  #state: the two letter abbreviation for the state.
  #year: the year.
  #cpi: consumer price index for the year.
  #pop: state population
  #packpc: average number of packs of cigarettes per capita 
    #per year
  #income: total state personal income.
  #tax: average state, federal, and average local excise 
    #taxes for fiscal year.
  #avgprs: average price per pack during fiscal year, 
    #ncluding sales taxes, in cents.
  #taxs: average excise taxes per pack for fiscal year, 
    #including sales taxes, in cents.


#Explore the data a bit more
  #View full dataset
View(Cigarette)
#output: data frame opened in separate tab - confirms there
    #are: 528 entries, 9 total columns
  #The numbers for things like price and packs seem too high 
    #(ie: a pack of cigarettes has not yet cost $80 in the US, 
    #AFAIK) or too low - wondering if these represents 1,000's

  #See which states are included (ie: all 50?)
levels(Cigarette$state)
#output: 48 states are included

  #Find out date range included
unique(Cigarette$year)
#output: 1985- 1995 (11 total years)


#Create a new replica data frame with a shorter title to type
cig <- data.frame(Cigarette)
View(cig)
#output: data saved and viewed in separate tab - confirming
  #it still has: 528 entries, 9 total columns


# Bullet Point 1 from course content --------------------------------------

#*Create a boxplot of the average number of packs per capita 
  #by state.

  #Group data by state, compute average packs per capita,
    #ordered from least to most packs per capita, and save 
    #it
cigStMdPkpc <- cig %>% group_by(state) %>% 
  summarise(MdPkpc = median(packpc)) %>% 
  arrange(MdPkpc)
cigStMdPkpc
#output: tibble printed in console with first 10 of 48 rows
    #and data saved
  #Surprised to see CA as the third lowest state! I still
    #remember smoking sections in the '80's and cigarette 
    #vending machines in the fronts of restaurants back then
  #As a best coast girl, it's nice to see CA (where I grew
    #up) and WA (where I live now) in the lowest 5 - states
    #overall are largely west coast and southwest
  #The 5 states with lowest avg. packs per capita:
    #Utah
    #New Mexico
    #California
    #Washington
    #Idaho

  #order same data from high to low
cigStMdPkpc <- cig %>% group_by(state) %>% 
  summarise(MdPkpc = median(packpc)) %>% 
  arrange(desc(MdPkpc))
cigStMdPkpc
#output: tibble printed in console with first 10 of 48 rows
    #and data saved
  #There's more regional variety in the 10 states with 
    #highest per capita packs, though a bit of an east 
    #coast theme.. is tobacco grown there? Nevada's the 
    #10th highest - which I'm guessing makes it an outlier 
    #for the southwest states, but makes sense given Vegas 
    #and Reno
  #The 5 states with highest avg. packs per capita:
    #Kentucky
    #New Hampshire
    #Indiana
    #North Carolina
    #Delaware

  #create a box plot of this averaged data
ggplot(cigStMdPkpc, aes(x = state, y = MdPkpc)) + 
  geom_boxplot(color = "purple") + xlab("State") + 
  ylab("Average Packs per Capita") + 
  ggtitle("Average Packs per Capita by State")
#output: a labeled, side by side box plot ... with an x 
    #axis that is illegible (50 states don't fit!)
  #This definitely shows a variety of averages across the
    #states, though most are within the range of 75- 125

  #*Which states have the highest number of packs?
    #The 5 states with highest avg. packs per capita:
      #Kentucky
      #New Hampshire
      #Indiana
      #North Carolina
      #Delaware

  #*Which have the lowest?
    #The 5 states with lowest avg. packs per capita:
      #Utah
      #New Mexico
      #California
      #Washington
      #Idaho


# Bullet Point 2 from course content --------------------------------------

#*Find the median over all the states of the number of packs 
  #per capita for each year.
cigYrMdPkpc <- cig %>% group_by(year) %>% 
  summarise(MdPkpc = median(packpc)) %>% 
  arrange(MdPkpc)
cigYrMdPkpc
#output: tibble printed in console with all 11 rows
    #and data saved
  #Data shows that the average packs per capita went down
    #every year from 1985- 1994, and then stayed the same in
    #1995
  #This makes sense, given the fact that awareness of lung
    #cancer and other implications were on the rise
  #Looks like the data are negatively correlated - as the
    #year goes up, the per capita packs go down

  #*Plot this median value for the years from 1985 to 1995.

  #Try diff. kinds of plots - line
ggplot(cigYrMdPkpc) + geom_line(aes(x = year, y = MdPkpc))
#output: a line graph that shows that the variables are 
  #strongly and negatively correlated - avg. per capita packs 
  #went down noticeably as the timeline progresses  until the 
  #last year of the data which remained status quo

  #Try diff. kinds of plots - scatter
ggplot(cigYrMdPkpc) + 
  geom_point(aes(x = year, y = MdPkpc, color = "purple")) +
  scale_x_discrete(limits = c(1985:1995)) +
  theme(legend.position = "none") +
  xlab("Year") +
  ylab("Average Packs per Capita") +
  ggtitle("Average Packs per Capita by Year")
#output: scatter plot that shows the same as the line
    #graph, but also more clearly shows that there was a big
    #drop in avg. per capita packs from about 1989 to 1990
  #Per choosing to use this graph, I found the 
    #scale_x_discrete function to clean up how the years are
    #represented on the x axis, as well as the theme function
    #and legend.position argument to hide a legend that said
    #"purple" only and was taking up space with no value

  #*What can you say about cigarette usage in these years?
    #The average per capita packs for the 48 states in this
    #data went down pretty noticeably from 1985 to 1995


# Bullet Point 3 from course content --------------------------------------

#*Create a scatter plot of price per pack vs number of packs 
  #per capita for all states and years
ggplot(cig) + 
  geom_point(aes(x = avgprs, y = packpc, color = "purple")) +
  theme(legend.position = "none") +
  xlab("Average Price in Dollars") +
  ylab("Packs per Capita") +
  ggtitle("Packs per Capita by Average Price")
#output: a scatter plot that shows that the data are 
    #moderately and negatively correlated - as price goes up,
    #average packs per capita go down
  #It makes sense to me that price would affect numbers per
    #capita, and it also makes sense that the correlation is
    #only moderate, given there were other variables that 
    #affected sales decreasing - such as a better 
    #understanding of health risks associated with smoking

# Bullet Point 4 from course content --------------------------------------

  #*Are the price and the per capita packs positively 
      #correlated, negatively correlated, or uncorrelated? 
    #As noted above they are moderately and negatively
      #correlated - as price goes up, per capita packs go 
      #down

    #*Explain why your answer would be expected.
      #As noted above this meets my expectations - that 
        #price affects packs per capita, though not as the
        #only variable that does!


# Bullet Point 5 from course content --------------------------------------

#*Change your scatter plot to show the points for each year 
  #in a different color.
ggplot(cig) + 
  geom_point(aes(x = avgprs, y = packpc, 
                 color = factor(year))) +
  scale_color_discrete(name = "Year") +
  xlab("Average Price in Dollars") +
  ylab("Packs per Capita") +
  ggtitle("Packs per Capita by Average Price & Year")
#output: scatter plot now is a pretty rainbow scale and shows
    #the data around 1985 (beginning) is on the left 
    #(lower cost and more packs per capita), the data around 
    #1990 (middle) is on the right (higher cost and less 
    #packs per capita), and the data around 1995 (latest) 
    #are in the middle (mid range cost and moderate packs per
    #capita
  #It's interesting that the most recent data are in the
    #middle - does this imply that price has a bigger impact 
    #on per capita numbers in more recent data?
  #And it should probably be noted that there are a fair 
    #amount of both high and low outliers
  #I found the scale_color_discrete function to clean up how 
    #the legend title is shown, per using factor to represent
    #all years in the legend

  #Check price by year to help understand the scatter plot
    #scatter plot
ggplot(cig) + geom_point(aes(x = year, y = avgprs))
#output: shows a pretty wide range of prices per year which
  #gets even wider over time - so this helps explain why it's
  #challenging to interpret the requested graph

  #create scatter plots with subsets of data to further 
    #investigate create subsets of years
cig85to88 <- filter(cig, year < 1989)
View(cig85to88)
#output: subset saved with data from 1985- 1988 and opened in 
  #new tab: 192 entries, 9 total columns

      #confirm how much of the data this represents (new 
        #entries by original)
192 / 528
#output: 0.3636364 - aka: 36% of the data is from the first 4 
  #years

cig85to91 <- filter(cig, year < 1992)
#output: subset saved with data from 1985- 1991

cig89to91 <- filter(cig85to91, year > 1988)
View(cig89to91)
#output: subset saved with data from 1989- 1991 and opened in 
  #new tab: 144 entries, 9 total columns

      #confirm how much of the data this represents (new 
        #entries by original)
144 / 528
#output: 0.2727273 - aka: 27% of the data is from the middle 3 
  #years

cig92to95 <- filter(cig, year > 1991)
View(cig92to95)
#output: subset saved with data from 1992- 1995 and opened in 
    #new tab: 192 entries, 9 total columns
  #Since this is the same amount of data (36%) from the first 4 
    #years, one idea I had that data was overloaded in one time
    #period or another is disproved

    #Guessing this also means that there is one observation per 
      #state per year, which would make sense
528 / 48
#output: 11 - yep, the total observations (528) divided by the 
  #number of states in the data (48) = the number of years (11)

    #create scatter plots for each subset of years
ggplot(cig85to88) + geom_point(aes(x = avgprs, y = packpc,
                                 color = factor(year)))
#output: scatter plot shows a clear relationship between the 3 
    #variables: over time pack prices increase and packs per 
    #capita decrease; there are also still a lot of high and 
    #low outliers
  #For the bulk of the data, there is about a $50 increase and 
    #60 decrease in packs

ggplot(cig89to91) + geom_point(aes(x = avgprs, y = packpc,
                                   color = factor(year)))
#output: same general outcome as above, though the data seem to 
    #have a weaker correlation as the data are more spread out 
    #and there are lots of outliers still
  #For the bulk of the data, there is about a $55 increase and 
    #65 decrease in packs  

ggplot(cig92to95) + geom_point(aes(x = avgprs, y = packpc,
                                   color = factor(year)))
#output: not surprisingly based on the first (overall) scatter 
    #plot, in this one with the most recent data, there is no 
    #noticeable impact from time on the relationship between 
    #packs per capita and prices
  #I wonder if this is in part due to the last 2 (of these 4) 
    #years having the same price
  #For the bulk of the data, there is about a $70 increase and 
    #65 decrease in packs - this is interesting that there was 
    #a bigger overall price increase in these last 4 years, 
    #especially knowing that there was no price change in the 
    #last year

  #*Does the relationship between the two variable change over 
      #time?
    #Time does not appear to change the relationship between 
      #price and per capita packs. In the older data, as time 
      #goes on, prices continue to go up, and thus packs go 
      #down. In the more recent data, the prices fluctuate 
      #more, and the packs per capita fluctuate with the price 
      #changes.


# Bullet Point 6 from course content --------------------------------------

  #*Do a linear regression for these two variables.
cigPkPrcLin <- lm(packpc ~ avgprs, cig)
summary(cigPkPrcLin)
#output: test statistics saved and printed in console
    #y-intercept: 167.87737
    #slope: -0.40879
    #Adjusted R-squared: 0.3415 (34% of variance)
    #Overall p-value: < 2.2e-16
  #test is significant (p: < 2.2e-16 < 0.05)
    #H0 rejected, H1 accepted

 #plugging the last avgprs value for 1995 with test statistics 
  #into formula: y = (m*x) + b
(-0.40879 * 158.5417) + 167.87737
#output: y = 103.0671
  #A $158.54 price results in 103 packs per capita

  #*How much variability does the line explain?
    #Price explains 34% of variance in per capita packs -
    #which aligns with the scatter plot showing a moderate
    #correlation


# Bullet Point 7 from course content --------------------------------------

#*The plot above does not adjust for inflation. You can 
  #adjust the price of a pack of cigarettes for inflation by 
  #dividing the avgprs variable by the cpi variable
  
  #*Create an adjusted price for each row, then re-do your 
    #scatter plot and linear regression using this adjusted 
    #price
  
  #Create a new column for inflation prices and view it to 
    #confirm
cig$inflPrc <- (cig$avgprs / cig$cpi)
View(cig)
#output: new column added to dataset, and dataset opened in
  #new tab

  #sanity check values in new column by manually computing
    #the same equation on the first line, and subtracting
    #the value from the new column (which should = 0)
(102.18167 / 1.076) - 94.96438
#output: -2.67658e-06 - that's close enough to 0 for me ;)

  #create updated scatter plot using inflated prices
ggplot(cig) + geom_point(aes(x = inflPrc, y = packpc,
                             color = factor(year))) +
  scale_color_discrete(name = "Year") +
  xlab("Average Inflated Price in Dollars") +
  ylab("Packs per Capita") +
  ggtitle("Packs per Capita by Average Inflated Price & Year")
#output: correlation between the inflated price and packs per 
  #capita on this new scatter plot does not appear to be very 
  #different from the original (without inflation), but the 
  #price range is nearly double (without inflation is about 
  #$80, and with inflation is about $160 - including outliers 
  #for both)

  #compute updated linear regression test using inflated prices
cigInflLin <- lm(packpc ~ inflPrc, cig)
summary(cigInflLin)
#output: test statistics saved and printed in console
    #y-intercept: 211.76821
    #slope: -0.91640
    #Adjusted R-squared: 0.3757 (38% of variance)
    #Overall p-value: < 2.2e-16
  #test is significant (p: < 2.2e-16 < 0.05)
    #H0 rejected, H1 accepted
  #Note: Inflated price has a greater impact (38% of variance) 
    #than #non-inflated price (34% of variance)

#plugging last 1995 inflated price value with test statistics 
  #into formula: y = (m*x) + b
(-0.91640 * 104.02996) + 211.76821
#output: y = 116.4352
  #An inflated price of $104.03 results in 116 packs per 
    #capita


# Bullet Point 8 from course content --------------------------------------

#*Create a data frame with just the rows from 1985
cig85 <- filter(cig, year == 1985)
View(cig85)
#output: subset created and opened in new tab, validating that 
  #only 1985's observations are included: 48 entries, 10 total 
  #columns

#*Create a second data frame with just the rows from 1995
cig95 <- filter(cig, year == 1995)
View(cig95)
#output: subset created and opened in new tab, validating that 
  #only 1995's observations are included: 48 entries, 10 total 
  #columns

#*Then, from each of these data frames, get a vector of the 
  #number of packs per capita
cig85Packpc <- (cig85$packpc)
cig85Packpc
#output: vector created and 48 indexed packpc values printed in
  #console

cig95Packpc <- (cig95$packpc)
cig95Packpc
#output: vector created and 48 indexed packpc values printed in
  #console

#*Use a paired t-test to see if the number of packs per capita 
  #in 1995 was significantly different than the number of packs 
  #per capita in 1985
    #H0: mu2 - mu1 = 0
    #H1: mu2 - mu1 != 0
t.test(cig95Packpc, cig85Packpc, paired = TRUE)
#output: data frame with t-test statistics created, then
    #printed on console
  #test is significant (p: < 2.2e-16 < 0.05)
    #H0 rejected, H1 accepted
  #Avg. packs per capita in 1995 - avg. packs per capita in 
    #1985: -25.70863
  #translates to: average packs per capita were significantly 
    #lower in 1995 than they were in 1985

#Validate translation by viewing both means
mean(cig85Packpc)
mean(cig95Packpc)
#output: mean of 1985 (122.0367) is higher than the mean of 
  #1995 (96.32811), which validates the results above


# Bullet Point 9 from course content --------------------------------------

#*In the process of doing this project, have any questions come 
  #to mind that this data set could answer? If so, pick one and 
  #do the analysis to find the answer to your question

#Really interesting that states' total personal incomes are
  #included.. very much wondering how that correlates with
  #other data - will test:

  #Does a state's personal income have an impact on packs per 
  #capita:
    #H0: state personal income has no impact on packs per 
      #capita
    #H1: state personal income has an impact on packs per 
      #capita

    #compute linear regression test
cigIncmPackpc <- lm(packpc ~ income, cig)
summary(cigIncmPackpc)
#output: test statistics saved and printed in console
    #y-intercept: 1.115e+02
    #slope: -5.047e-08
    #Adjusted R-squared: 0.06344 (6% of variance)
    #Overall p-value: 2.628e-09
  #test is significant (p: 2.628e-09 < 0.05)
    #H0 rejected, H1 accepted
  #Personal income has a small but significant impact on
    #packs per capita

    #plugging last 1995 income value with test statistics into 
      #formula: y = (m*x) + b
(-5.047e-08 * 10293195) + 1.115e+02
#output: y = 110.9805
  #An income of $10,293,195 results in 111 packs per capita
  #Also noting again that these numbers don't align well - 
    #it seems like the personal income is a total # and the
    #packs per capita is a representative # (ie: 1,000's
    #maybe?)

    #graph the variables to visualize
ggplot(cig) + geom_point(aes(x = income, y = packpc,
                             color = "purple")) +
  theme(legend.position = "none") +
  xlab("Personal Income in Dollars") +
  ylab("Packs per Capita") +
  ggtitle("Packs per Capita by Personal Income")
#output: scatter plot is a funny shape - it shows that the 
    #income and packs per capita  are weakly and negatively 
    #correlated - as income rises, packs per capita fall

#Summary: Income has a small but significant effect on packs 
  #per capita. I had expected it would have a greater impact - 
  #in either direction (ie: more money to spend leads to 
  #higher sales, or lower income leads to more stress smoking), 
  #but it certainly makes sense that the price of packs has a 
  #greater impact, as well as all the information related to 
  #health consequences that came to light over time