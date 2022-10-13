#DSO102 - Statistical Programming in R
  #Lesson 9 - Data Exploration

  #Page 2 - Data Exploration

#load relevant packages
library(ggplot2)
library(dplyr)
library(readxl)


#From video

#Finally found dataset, since she showed the original file name
  #Upload that data
train_accidents <- 
  read_excel("/Users/hannah/Desktop/train_acc_2010.xls")
View(train_accidents)
#output: created new data frame and opened in separate tab

#View documentation for the data set
  #https://users.stat.ufl.edu/~winner/data/train_acc_2010.txt
  #Important to familiarize yourself with data early on

#Create a bar graph of accidents per month
ggplot(train_accidents, aes(x = Month)) + geom_bar()
#output: bar graph shows that there were fewer accidents in May and
  #Sep, as well as in April and November
  #Maybe less trains operate in spring and summer?

#Create a graph to focus on accidents by state
ggplot(train_accidents, aes(x = State)) + geom_bar()
#output: bar graph shows that there were a lot of accidents in TX and
  #Illinois; both have a lot of trains and are in the middle of the
  #country so they probably see a lot of traffic; TX also is big 
  #enough that it probably sees more traffic
  #There were less accidents in AK, DC, DE, ME, RI, etc. - likely b/c
  #they're small or aren't popular (less trains will be going to
  #Alaska)

#Create a graph to look at accidents only in TX, as well as ordering
  #by equipment damage
TXtrains <- train_accidents %>% filter(State == "TX") %>% 
  arrange(EqpDamg)
TXtrains
#output: new data saved and viewed which has only the train_accidents
  #observations for Texas, in ascending order by cost of equipment
  #damage

#Look at outliers in equipment damage costs for Texas, looking at it
  #as a factor by month
ggplot(TXtrains, aes(x = Month, y = EqpDamg)) +
  geom_boxplot(aes(group = TXtrains$Month))
#output: side-by-side scatter plot that shows expensive accidents in 
    #June, March, and Feb as noticeable outliers
  #Note: had to trial and error a LOT to be able to replicate her
  #graph - she used geom_boxplot(by="Month") which didn't work to do
  #a side-by-side plot - what's above did (whew)


#From lesson

#Install new package, load it, and preview data it includes
install.packages("gapminder")
library(gapminder)
head(gapminder)
#output: package installed and enabled, and tibble preview of its 
  #data printed in console

#Review description file for gapminder package by finding it on 
  #package pane and opening DESCRIPTION file link:
  #http://127.0.0.1:62740/help/library/gapminder/DESCRIPTION

#Preview all countries in the data set by asking for the levels of 
  #the country factor
levels(gapminder$country)
#output: 142 indexed countries printed in console

#Preview all years in the data set by asking for the unique values of
  #the year variable
unique(gapminder$year)
#output: 12 values of 5 year increments from 1952- 2007

#testing unique function, since it's new to me, to see if it works
  #like the levels function in also giving all values for data set
  #if no column is named
unique(gapminder)
#output: success - a preview printed of all values for all variables

#create a box plot to get a feel for how population of the countries
  #has changed over time
ggplot(gapminder, aes(x = factor(year), y = pop)) + geom_boxplot()
#output: side by side box plot - this was cool to learn the factor
  #trick to simply grouping
  #From lesson: This shows that some years had a very high population, 
    #but it makes it quite difficult to see the population of the 
    #smaller countries
  
#Change vertical scale to be logarithmic - to see small values as 
  #well as large
ggplot(gapminder, aes(x = factor(year), y = pop)) + 
  geom_boxplot() + scale_y_log10()
#output: side by side box plot that's much easier to ready and see
  #outliers on
  #From lesson: You can see that around 1982 one country passed the 1 
    #billion population mark, and around 1987 a second country passed 
    #this mark
  
#find the largest countries in 2007
gapminderBig <- gapminder %>% filter(year == 2007) %>% 
  arrange(desc(pop))
gapminderBig
#output: new data saved and preview tibble printed in console - 
  #this is all observations for 2007 only, sorted by population 
  #from largest to smallest

#print only first 10 lines in console to see largest countries
head(gapminderBig, n = 10)
#output: tibble printed in console with first 10 lines of data

#print only last 10 lines in console to see smallest countries
tail(gapminderBig, n = 10)
#output: tibble printed in console with last 10 lines of data

#plot the per capita GDP for each year
ggplot(gapminder, aes(x = factor(year), y = gdpPercap)) +
  geom_boxplot()
#output: side by side box plot
  #From lesson: On this plot, you see that there are outliers with a 
  #high per capita GDP between 1952 and 1977

#find out which country or countries these outliers represent
  #first calculate what values would be considered outliers
    #find the IQR
    #multiply it by 1.5
    #add it to the third quartile boundary
summary(gapminder$gdpPercap)
9325.5 - 1202.1
#output: 8123.4

8123.4 * 1.5
#output: 12185.1

12185.1 + 9325.5
#output: 21510.6
  #Note: the lesson has a bug which indicates the result of this
  #math is "13,988.25" which means the rest of that section on the
  #lesson page has different results from mine

#then filter for values above 21510.6
filter(gapminder, gdpPercap > 21510.6)
#output: a tibble preview printed in console with the first 10 of
  #143 rows / observations

#plot the life expectancy values for each year
ggplot(gapminder, aes(x = factor(year), y = lifeExp)) +
  geom_boxplot()
#output: side by side box plot printed with only one outlier, and
  #indicating that life expectency has increased over time

#find which country had the outlier - very low life expectancy in '92
filter(gapminder, lifeExp < 28)
#output: tibble printed in console shows that this was Rwanda :(
  #Hoping this is fake data


#from quiz - q2
#B
gapminderEur <- filter(gapminder, continent == "Europe")
ggplot(gapminderEur, aes(x = factor(year), y = lifeExp)) +
  geom_boxplot()
#output: doesn't match the quiz - but the code is accurate.. hmm
  #It was correct, so I think they have the wrong image there

#from quiz - q4
filter(gapminderEur, lifeExp < 53)
#output: tibble printed to show that the three years with a life
  #expectancy lower than 53 were all represented by Turkey :(



#Page 3 - Comparing Countries

#load relevant packages
library(ggplot2)
library(dplyr)


#From video
#Create a line graph to view train accident data for Texas
  #by day of the month
ggplot(TXtrains) + geom_line(aes(x = Day, y = EqpDamg)) +
  ylab("Equipment Damage in Dollars") +
  xlab("Day of the Month") +
  ggtitle("Equipment Damage in Dollars by Day of the 
          Month")
#output: line graph that shows the most accidents happen 
  #around the 15th and 19th of the month

#compare how accidents spread over the month for more states

#create new data to include more states
TXilCAtrains <- train_accidents %>% 
  filter(State == c("TX", "IL", "CA")) %>% 
  arrange(EqpDamg)
#output: saved

#create a new line graph, with color as a factor of
  #states, so you have a separate line per state
ggplot(TXilCAtrains) + geom_line(aes(x = Day, 
                                     y = EqpDamg,
                                     color = State)) +
  ylab("Equipment Damage in Dollars") +
  xlab("Day of the Month") +
  ggtitle("Equipment Damage in Dollars by Day of the 
          Month")
#output: line graph with three colored lines for the diff
  #states, and shows that only TX has inordinately high
  #equipment damage costs in the middle of the month

#Track equipment and track damage on the same graph
  #Enable gridExtra package
library(gridExtra)
#output: package enabled

#save the last graph
EquipmentDamage <- ggplot(TXilCAtrains) + 
  geom_line(aes(x = Day, y = EqpDamg,color = State)) +
  ylab("Equipment Damage in Dollars") +
  xlab("Day of the Month") +
  ggtitle("Equipment Damage in Dollars by Day of the 
          Month")
#output: graph saved

#create a new graph for track damage
TrackDamage <- ggplot(TXilCAtrains) + 
  geom_line(aes(x = Day, y = TrkDamg,color = State)) +
  ylab("Track Damage in Dollars") +
  xlab("Day of the Month") +
  ggtitle("Track Damage in Dollars by Day of the 
          Month")
TrackDamage
#output: line graph saved and viewed with three colored 
  #lines for the diff states, and shows that CA has 
  #inordinately high track damage costs in the 20th

#combine the graphs
grid.arrange(EquipmentDamage, TrackDamage, ncol = 1)
#output: the two graphs are stacked and can be viewed
  #together

#combine the graphs with track damage on top
grid.arrange(TrackDamage, EquipmentDamage, ncol = 1)
#output: the two graphs are stacked, with Track on top

#experimenting with the ncol argument
grid.arrange(TrackDamage, EquipmentDamage)
#output: same as above, so this makes ncol irrelevant
  #in this case

grid.arrange(TrackDamage, EquipmentDamage, ncol = 2)
#output: graphs printed side by side - ie: each in their
  #own column

#look at the # of cars derailed as a function of
  #accidents, in relation to the amount of equipment
  #damage
ggplot(TXilCAtrains, aes(x = Day, y = EqpDamg, 
                         color = State)) +
  geom_line() + geom_point(aes(size = CarsDer))
#output: line graph with three colored lines for the diff
  #states, and shows that only TX has inordinately high
  #equipment damage costs in the middle of the month AND
  #has dots to show cars derailed - with bigger dots 
  #representing more cars derailed (and vice versa)


#From lesson

#look at gapminder data for Angola
  #enable gapminder package
library(gapminder)
#output: package enabled

#create new subset with only gapminder observations
  #for Angola
gapminderAng <- filter(gapminder, country == "Angola")
head(gapminderAng)
#output: data saved and previewed via first 6 of 12 
  #lines printed in tibble in console

#plot life expectancy as a function of the year
ggplot(gapminderAng) + geom_line(aes(x = year, 
                                     y = lifeExp)) +
  ylab("Life Expectancy") +
  xlab("Year") +
  ggtitle("Life Expectancy in Angola by Year")
#output: a line graph which shows that life expectancy
  #in Angola has increased dramatically over time

#create a similar plot of per capita GDP for Angola
ggplot(gapminderAng) + geom_line(aes(x = year,
                                     y = gdpPercap)) +
  ylab("Per Capita GDP") +
  xlab("Year") +
  ggtitle("GDP in Angola by Year")
#output: a line graph which shows that per capita gdp
    #in Angola has fluctuated over time
  #From lesson: It looks like between the years of 1977 and 
    #2002, the GDP dropped significantly and the life 
    #expectancy did not improve. This coincides with a 
    #prolonged civil war in Angola :(

#Next, you do a comparative investigation into four 
  #African countries: Angola, Ghana, Ethiopia, and South 
  #Africa

#create a data frame with the data from these four 
  #countries
gapminderAfr <- filter(gapminder, country %in% c(
  "Angola", "Ghana", "Ethiopia", "South Africa"))
gapminderAfr
#output: subset of data created with only gapminder 
  #observations from these 4 countries, and previewed 
  #via first 10 of 48 lines printed in tibble in console

#eliminate unused variables
gapminderAfrCln <- select(gapminderAfr, country,
                          year, lifeExp, gdpPercap)
head(gapminderAfrCln)
#output: subset of data created with only defined 
  #variables included, and previewed via first 6 lines
  #printed in tibble in console

#preview another way to have created the same Clean
  #data in less steps
gapminderAfrCln2 <- gapminder %>% 
  filter(country %in% c("Angola", "Ghana", "Ethiopia", 
                        "South Africa")) %>% 
  select(country, year, lifeExp, gdpPercap)
head(gapminderAfrCln2)
#output: same subset of data from gapminder, with only
  #select countries and variables, created and previewed

#create a plot that shows the life expectancy in each 
  #of these four countries as a function of time
ggplot(gapminderAfrCln) + geom_line(aes(x = year,
                                        y = lifeExp,
                                        color = 
                                          country)) +
  ylab("Life Expectancy") +
  xlab("Year") +
  ggtitle("Life Expectancy by Year in 4 Countries")
#output: line plot created which shows that life
  #expectancy is going up in all but S. Africa, where
  #it is going down :(

#create a plot of per capita GDP
ggplot(gapminderAfrCln) + geom_line(aes(x = year,
                                        y = gdpPercap,
                                        color = 
                                          country)) +
  ylab("Per Capita GDP") +
  xlab("Year") +
  ggtitle("Per Capita GDP by Year in 4 Countries")
#output: line plot created which shows that per capita
  #gdp is steady and low in Ethiopia and Ghana, and has
  #fluctuated but is on the rise in Angola and S. Africa

#view both graphs together
  #save graph for each variable
gapminderAfrClnLife <- ggplot(gapminderAfrCln) + 
  geom_line(aes(x = year, y = lifeExp, 
                color = country)) +
  ylab("Life Expectancy") +
  xlab("Year") +
  ggtitle("Life Expectancy by Year in 4 Countries")
gapminderAfrClnGdp <- ggplot(gapminderAfrCln) + 
  geom_line(aes(x = year, y = lifeExp,
                color = country)) +
  ylab("Life Expectancy") +
  xlab("Year") +
  ggtitle("Life Expectancy by Year in 4 Countries")
#output: above graphs saved

#create combined graph
grid.arrange(gapminderAfrClnLife, gapminderAfrClnGdp)
#output: graphs combined and stacked to be viewed
    #together
  #From lesson: You can see from this plot that the life 
    #expectancy and the per capita GDP declined in South 
    #Africa beginning in the early 1990's. This is most 
    #likely a consequence of the devastating HIV/AIDS 
    #epidemic in sub-saharan Africa. You will also note 
    #that while per capita GDP in Ethiopia and Ghana did 
    #not increase dramatically over time, the life 
    #expectancy in these two countries did increase 
    #dramatically.

#try an alternate approach to representing both life 
  #expectancy and and per capita GDP on a single graph
ggplot(gapminderAfrCln, aes(x = year, y = lifeExp,
                            color = country)) +
  geom_line() + geom_point(aes(size = gdpPercap)) +
  ylab("Life Expectancy") +
  xlab("Year") +
  ggtitle("Life Expectancy & Per Capita GDP by Year in 4 
          Countries")
#output: line graph with all the things! lines represent
  #life expectancy, with dots for gdp

#Plotting GDP and Life Expectancy Against Each Other
  #start by plotting the per capita GDP on the horizontal 
  #axis and the life expectancy on the vertical axis
ggplot(gapminderAfrCln, aes(x = gdpPercap, 
                            y = lifeExp, 
                            color = country)) + 
  geom_point()
#output: a scatter plot that shows correlation between
  #life expectancy and gdp

#connect the series of points for each country with a 
  #line
ggplot(gapminderAfrCln, aes(x = gdpPercap, 
                            y = lifeExp, 
                            color = country)) + 
  geom_point() + geom_line()
#output: lines connect each country's dots...

#change shape of lines to connect data based on where
  #it is in data frame, instead of where it is on
  #graph
ggplot(gapminderAfrCln, aes(x = gdpPercap, 
                            y = lifeExp, 
                            color = country)) + 
  geom_point() + geom_path()
#output: starting to look more like a line graph

#convey a sense of the progression of time by changing 
  #the transparency of each point, with earlier points 
  #being ore transparent that later points
ggplot(gapminderAfrCln, aes(x = gdpPercap, 
                            y = lifeExp, 
                            color = country)) + 
  geom_point(aes(alpha = year)) + geom_path()
#output: time factor added in via transparency, but
  #earlier data are hard to see

#scale the transparency and increase the dots size to
  #increase readability
ggplot(gapminderAfrCln, aes(x = gdpPercap, 
                            y = lifeExp, 
                            color = country)) + 
  geom_point(aes(alpha = year), size = 3) + 
  geom_path() + scale_alpha(range = c(0.3, 1.0))
#output: a much easier to read graph of the 3 variables
  #and 4 countries

#add labels
ggplot(gapminderAfrCln, aes(x = gdpPercap, 
                            y = lifeExp, 
                            color = country)) + 
  geom_point(aes(alpha = year), size = 3) + 
  geom_path() + scale_alpha(range = c(0.3, 1.0)) +
  xlab("Per Capita GDP") +
  ylab("Life Expectancy") +
  ggtitle("Life Expectancy and GDP over Time in 4
          Countries")
#output: voila! a very readable graph which shows that
    #over time:
  #life expectancy has gone up noticeably, and gdp 
    #minimally in Ethiopia and Ghana
  #life expectancy has gone up while gdp has 
    #fluctuated in Angola
  #life expectancy and gdp have fluctuated in S. 
    #Africa


#From quiz - q1
#B
gapminderBig3 <- filter(gapminder, 
                        country == c("China", "India",
                                     "United States"))
gapminderBig3
#output: subset created, saved, and previewed via 12
  #line tibble in console
  #BUT this was incorrect answer - oops! so the right
  #function was:
#C
gapminderBig3 <- filter(gapminder, country %in% 
                          c("China", "India",
                            "United States"))
gapminderBig3
#output: subset created, saved, and previewed via first
  #10 of 36 lines in tibble in console


#From quiz - q2
#A
ggplot(gapminderBig3) + 
  geom_line(aes(x = year, y = lifeExp, color =
                  country))
#output: success


#From quiz - q3
#D
ggplot(gapminderBig3, aes(x = pop, y = gdpPercap, 
                          color = country)) +
  geom_point()
#output: success



#Page 4 - Statistical Summary

#load relevant packages
library(ggplot2)
library(dplyr)


#From video
#create a tibble of the median equipment damage
TrainsMedians <- TXilCAtrains %>% group_by(State) %>% 
  summarise(EqpDamgMed = median(EqpDamg))
TrainsMedians
#output: medians saved and printed in console
    #1 CA        14800 
    #2 IL        15288.
    #3 TX        11600
  #Interesting that TX has highest # of accidents, but
    #lowest average equip. damage cost


#From lesson
#create a tibble that has the medians of life expectancy 
  #and per capita GDP for all of the countries in Africa
gapminderAfrMed <- gapminder %>% 
  filter(continent == "Africa") %>% 
  group_by(year) %>% 
  summarise(lifeMed = median(lifeExp),
            gdpMed = median(gdpPercap))
gapminderAfrMed
#output: medians saved and printed in console - both
  #life expectancy and gdp have gone up noticeably
  #over time for the continent


#From quiz - q1
#D
gapminderLife <- gapminder %>% group_by(year) %>% 
  summarise(lifeMed = median(lifeExp))
gapminderLife
#output: success!



#Page 12 - Hands-On Workshop

#load potentially relevant packages
library(addinexamples)
library(dplyr)
library(ggplot2)

#import data (used button)
#NOTE: I had to check the "Strings as factors" box!

#preview data
View(top10s)
#output: data opened in new tab
#Just noticed line below data shows total number of
  #rows and columns, and it's even selectable to copy - 
  #this data has: 603 entries, 15 total columns

#Find the different artists
levels(top10s$artist)
#output: 184 indexed artists printed in console in 
  #alphabetical order

#Find years
unique(top10s$year)
#output: indexed years printed in console - data is from
  #2010- 2019

#Look at top of data
head(top10s)
#output: first 6 rows printed in console

#Look at end of data
tail(top10s)
#output: last 6 rows printed in console

#Figure out how beats per minute by artist
ggplot(top10s, aes(x = artist, y = bpm)) + geom_boxplot()
#output: Looks like music, haha - an illegible x axis

#Filter to include only some female artists
Ladies <- top10s %>% filter(
  artist %in% c("Lady Gaga", "Rhianna", "Alicia Keys",
                "Katy Perry", "Britney Spears"))
View(Ladies)
#output: subset saved and opened in new tab

#Find beats per min. for subset
ggplot(Ladies, aes(x = artist, y = bpm)) + geom_boxplot()
#output: legible, side by side boxplot
  #Katy Perry has a broad spectrum with high and low 
    #outliers
  #Alicia Keys is lower overall

#Add artists as a color
ggplot(Ladies, aes(x = year, y = bpm, color = artist)) +
  geom_line()
#output: a lot of variety!

#Find highest bpm in 2010 and 2019
filter(Ladies, year %in% c(2010, 2019)) %>% 
  arrange(desc(bpm))
#output: lots of data printed in console, per data having
  #so many columns

#Update to include only a few columns
filter(Ladies, year %in% c(2010, 2019)) %>% 
  arrange(desc(bpm)) %>% select(artist,bpm,year)
#output: a nice tidy list printed in console, though only
  #has data for 2010 - apparently these artists had no
  #data reflected in 2019 (or none with bpm logged)
  #Britney Spears had highest bpm

#Find lowest bpm in 2010 and 2019
filter(Ladies, year %in% c(2010, 2019)) %>% 
  arrange(bpm) %>% select(artist,bpm,year)
#output: list printed in console
  #Alicia Keys had lowest bpm

#Find median bpm per year
LadiesMed <- Ladies %>% select(year, bpm) %>% 
  group_by(year) %>% summarise(bpmMed = median(bpm))
LadiesMed
#output: results printed in console
  #Highest in 2012, lowest in 2018