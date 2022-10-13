library(ggplot2)
library(dplyr)

#Set the table
  #View dataset to be used in Hands-On
View(mtcars)
#output: mtcars data frame opened in separate tab

  #gather basic info about dataset to use in presentation
    #total # of variables
length(mtcars)
#output: 11

    #total # of observations
length(mtcars$mpg)
#output: 32


#Create a box plot of miles per gallon (the mpg variable) 
  #grouped by the number of cylinders in the engine (the cyl 
  #variable)
ggplot(mtcars, aes(x = cyl, y = mpg)) +
  geom_boxplot(aes(group = cyl))
#output: side-by-side boxplot of mpg by cylinders
  #there does seem to be a correlation of cylinders and mpg
  #the more cylinders, the worse mpg

#Pretty up the box plot
ggplot(mtcars, aes(x = cyl, y = mpg)) +
  geom_boxplot(aes(group = cyl),
               color = "dark green",
               fill = "green",
               outlier.color = "red") +
  ylab("MPG") +
  xlab("Cylinders") +
  ggtitle("MPG by Number of Cylinders")
#output: nicely labeled and colored version of box plot above


#Use the summarize() and group_by() functions to compute how 
  #many cars have four cylinders, how many have six, and how 
  #many have eight

#fist attempt
mtcars %>%
  group_by(cyl) %>% 
  summarise(cyl = n())
#output: 3x1 tibble with counts per cylinder - but I'm not
  #sure how to know which count goes to which cylinder (insert
  #upside down emoji face here)

#second attempt
mtcars %>%
  group_by(cyl) %>% 
  summarise(count = n())
#remembered this was not graded and looked ahead to the code
  #I had forgotten that where "count" is would be a new name,
  #not the name of the column being summarized (insert
  #facepalm emoji here)