#DSO102 - Statistical Programming in R
  #Lesson 9 - Data Exploration
  #Page 12 - Hands-On

#load potentially relevant packages
library(ggplot2)
library(dplyr)


#For this Hands-On, you will compare five countries of your choice. 
  #You can see the countries in the gapminder data frame with the 
  #command: levels(gapminder$country)

#Set the table
  #Install and load gapminder dataset
install.packages("gapminder")
library(gapminder)
#output: dataset installed and loaded

  #View dataset to be used in Hands-On
View(gapminder)
#output: gapminder data frame opened in separate tab

  #gather basic info about dataset to use in presentation
    #total # of variables
length(gapminder)
#output: 6

    #total # of observations
length(gapminder$country)
#output: 1704

  #view all countries in gapminder dataset
levels(gapminder$country)
#output: all 142 countries printed in console, in alphabetical order


#Choose five countries from the resulting list after running the 
    #above command. Then use them to answer each of these questions:
  #Which country of the five you chose has the lowest per capita 
    #GDP in 1952?
      #In 2007?
  #Which has the highest per capita GDP in 1952?
    #In 2007?
  #Create a line plot with year on the horizontal axis and lifeExp  
    #on the vertical axis for the five countries; give each country 
    #a different color line.
      #Describe the variations in life expectancy between the 
        #countries.
  #On the entire gapminder data frame, compute the median of 
    #lifeExp for each year.
      #For what years is the life expectancy for your five 
        #countries above the median life expectancy for the entire 
        #gapminder data frame?


#Choose 5 countries:
  #"Argentina", "Ireland", "Japan", "Kenya", "New Zealand"

#Save and preview a subset of gapminder data set with these 5 
  #countries
gap5 <- filter(gapminder, country %in% c("Argentina", "Ireland", 
                                         "Japan", "Kenya", 
                                         "New Zealand"))
gap5
#output: subset of data saved and previewed via a tibble printed in
  #console with first 10 of 60 rows


  #Which country of the five you chose has the lowest per capita GDP 
    #in 1952?

#filter gap5 data to only include observations for the year 1952 and
  #arrange it in ascending order by gdp
gap5 %>% filter(year == "1952") %>% arrange(gdpPercap)
#output: console printed tibble with 5 rows showing data for each
    #country for 1952 only, ordered by gdp (low to high)
  #Kenya had the lowest per capita gdp in 1952, at $854

  #Which country of the five you chose has the lowest per capita GDP 
    #in 2007?

#filter gap5 data to only include observations for the year 2007 and
  #arrange it in ascending order by gdp
gap5 %>% filter(year == "2007") %>% arrange(gdpPercap)
#output: console printed tibble with 5 rows showing data for each
   #country for 2007 only, ordered by gdp (low to high)
  #Kenya had the lowest per capita gdp in 2007, as well, at $1,463


  #Which has the highest per capita GDP in 1952?

#filter gap5 data to only include observations for the year 1952 and
  #arrange it in descending order by gdp
gap5 %>% filter(year == "1952") %>% arrange(desc(gdpPercap))
#output: console printed tibble with 5 rows showing data for each
    #country for 1952 only, ordered by gdp (high to low)
  #New Zealand had the highest per capita gdp in 1952, at $10,557

  #Which has the highest per capita GDP in 2007?

#filter gap5 data to only include observations for the year 2007 and
  #arrange it in descending order by gdp
gap5 %>% filter(year == "2007") %>% arrange(desc(gdpPercap))
#output: console printed tibble with 5 rows showing data for each
    #country for 2007 only, ordered by gdp (high to low)
  #Ireland had the highest per capita gdp in 2007, at $40,676


#Create a line plot with year on the horizontal axis and lifeExp  
    #on the vertical axis for the five countries; give each country 
    #a different color line.
  #Describe the variations in life expectancy between the 
    #countries.
ggplot(gap5) + geom_line(aes(x = year, y = lifeExp, 
                             color = country)) +
  xlab("Year") +
  ylab("Life Expectancy") +
  ggtitle("Life Expectancy by Year in 5 Countries")
#output: a labeled line plot which shows that life expectancy
  #has consistently and moderately gone up over time in Argentina, 
    #Ireland, Japan, and New Zealand - with the biggest increase in
    #Japan
  #was strongly increasing in Kenya from 1952 through 1990, then 
    #decreased until around 2002, when it began to increase again - 
    #though the latest data are not yet as high as 1990

#On the entire gapminder data frame, compute the median of lifeExp 
    #for each year.
  #For what years is the life expectancy for your five countries 
    #above the median life expectancy for the entire gapminder 
    #data frame?

  #Find median life expectancy by year for overall gapminder dataset
gapMedLife <- gapminder %>% group_by(year) %>% 
  summarise(gapLifeExpMed = median(lifeExp)) %>% 
  arrange(desc(gapLifeExpMed))
gapMedLife
#output: data saved and console printed tibble with 12 rows showing 
  #median life expectancy for each year across full gapminder 
  #dataset, ordered by life expectancy (longest to shortest)

  #Find median life expectancy by year for subset of 5 countries
gap5MedLife <- gap5 %>% group_by(year) %>% 
  summarise(gap5LifeExpMed = median(lifeExp)) %>% 
  arrange(desc(gap5LifeExpMed))
gap5MedLife
#output: data saved and console printed tibble with 12 rows showing 
    #median life expectancy for each year across the subset of 5 
    #countries, ordered by life expectancy (longest to shortest)
  #From a visual check, it looks like all 12 years' medians are
    #higher for the subset countries than the overall medians

  #Create new data frame which has median life expectancy from both 
    #the overall dataset and the subset of 5 countries
gapAnd5MedLife <- data.frame(gap5MedLife$year, 
                             gap5MedLife$gap5LifeExpMed,
                             gapMedLife$gapLifeExpMed)
gapAnd5MedLife
#output: data saved and printed in console
  #From a visual check, it looks like all 12 years' medians are
  #higher for the subset countries than the overall medians

  #Find only the years from subset of 5 countries where the median
    #life expectancy is greater than that of the overall dataset
gapAnd5MedLife %>% filter(gap5MedLife.gap5LifeExpMed > 
                            gapMedLife.gapLifeExpMed) %>% 
  arrange(desc(gap5MedLife.gap5LifeExpMed))
#output: all 12 years printed, which validates visual check above

  #One last sanity check, to be sure my last computation holds water
    #by using it to preview observations when overall median is 
    #higher than subset median.. which should be empty
gapAnd5MedLife %>% filter(gapMedLife.gapLifeExpMed > 
                            gap5MedLife.gap5LifeExpMed) %>% 
  arrange(desc(gapMedLife.gapLifeExpMed))
#output: success! console printed 0 observations
