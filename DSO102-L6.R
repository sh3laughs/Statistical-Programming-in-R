#DSO102 - Statistical Programming in R
  #Lesson 6 - Data Frames

  #Page 2 - Creating and Viewing Data Frame
library(ggplot2)

#From video
  #create data frame from scratch (not common IRL ;)

  #create vector for each column
SnowmanName <- c("Frosty", "Frostette", "Jack Frost", 
                 "Jackie Frost", "Coal Eye")
Accessory <- c("Top Hat", "Scarf", "Coal Buttons", "Twig Arms", 
               "Carrot Nose")
Location <- c("South Dakota", "North Dakota", "Colorado", 
              "Minnesota", "Alaska")
BodySections <- c(3,4,2,3,3)

  #create data frame
Snowmen <- data.frame(SnowmanName,Accessory,Location,
                      BodySections)


  #view first 6 rows of data frame (if there were more than 6)
head(Snowmen)

  #view last 6 rows of data frame (if there were more than 6)
tail(Snowmen)

  #view full data frame in console
Snowmen

  #view data frame in separate window - can also do this by 
    #clicking name in environment
View(Snowmen)

  #view single column (Accessory) of data frame in console
Snowmen$Accessory

  #view single row (3) of data frame in console (via subsetting)
Snowmen[3,]
#note that the comma is necessary, w/o it the output was the 
  #Location column data

  #view single cell (row 3, column 2) of data frame in console 
    #(via subsetting)
Snowmen[3,2]
#NOTE: I'm missing "levels" in the console output that is in 
  #the video and I haven't figured out why yet

  #Michael W. (mentor) LMK that I can use the factor function
    #to print levels - testing a few options
factor(Snowmen)
factor(Snowmen[3,])
factor(Snowmen[3,2])
#output: these do print the levels selected, but not all
  #possible levels, as in the video example...

  #a Google search helped me carry it all the way through
    #https://www.tutorialspoint.com/how-to-extract-the-factor-levels-from-factor-column-in-an-r-data-frame
levels(factor(Snowmen$Accessory))
#output: all levels (possible values) for the selected factor 
  #(column) printed in console

  #couldn't drop it once I was trying to add notes about the
    #factor and levels functions, and tried a couple more
factor(Snowmen[2])
factor(Snowmen$Accessory)
#output: both print the levels for this factor - the top one
  #prints it right justified first, then summed up in a
  #"levels" line; the lower line prints it left justified
  #then the summary line, so that's winner winner chicken
  #dinner (even though it's not the same as the video)

  #To later add additional columns to data frame use $
Snowmen$Gender <- c("Male", "Female", "Male", "Female", "Male")


#From lesson
  #create data frame from scratch (not common IRL ;)

  #create vector for each column
Name <- c("Bob", "Nancy", "Cyrus", "Jackie")
Age <- c(36, 31, 26, 34)
DominantHand <- c("Right", "Right", "Left", "Right")

  #create data frame
Friends <- data.frame(Name, Age, DominantHand)


  #view data frame in separate window
View(Friends)

  #view full data frame in console
Friends

  #view first 6 rows of data frame (if there were more than 6)
head(Friends)

  #view last 6 rows of data frame (if there were more than 6)
tail(Friends)

  #view  each column/ variable of data frame in console
Friends$Name
Friends$Age
Friends$DominantHand

  #view single row (3) of data frame in console (via subsetting)
Friends[3,]

  #view single cell (row 3, column 2) of data frame in console 
Friends[3, 2]

  #add column to data frame
Friends$ShoeSize <- c(10,8,14,9)
View(Friends)


  #Page 3 - Built-in Data Frames
library(ggplot2)

#From video
  #view dataset
View(ToothGrowth)
ToothGrowth


#From lesson
  #view a different dataset
mtcars

  #view only first 6 rows of dataset
head(mtcars)

  #view only last 6 rows of dataset
tail(mtcars)

  #view help info for the dataset (b/c it's a built in set)
help("mtcars")



  #Page 4 - Importing CSV Data
library(ggplot2)

#From video (NOTES ONLY)
  #import csv (comma separated value) file

  #if needed, save your spreadsheet as a csv file

  #use Import Dataset button on Environment pane
    #use "From Text (base)..." option
    #select file and Open
    #update options in popup import window, if helpful, and import

  #OR use read function to import file


#From lesson
  #create data frame from csv
myPets <- read.csv("/Users/hannah/Library/CloudStorage/GoogleDrive-gracesnouveaux@gmail.com/My Drive/Bethel Tech/Data Science/DSO102 Statistical Programming in R/Lesson 6: Data Frames/PetsCSV.csv")



  #Page 5 - Importing an MS Excel File
library(ggplot2)

#import Excel file file

#use Import Dataset button on Environment pane
  #use "From Exel..." option
  #select file and update options in popup import window, if 
    #helpful, and import
  #Click on column name drop downs to select data type or to 
    #skip (exclude) the column

#OR use read function to import file
install.packages("readxl")
library("readxl")


#From lesson
#create data frame from Excel using code
library("readxl")
myPetsExcel <- read_excel("/Users/hannah/Library/CloudStorage/GoogleDrive-gracesnouveaux@gmail.com/My Drive/Bethel Tech/Data Science/DSO102 Statistical Programming in R/Lesson 6: Data Frames/Pets.xlsx")



  #Page 6 - Manipulating Data
library(ggplot2)

#Nothing from video (just notes in doc)

#From lesson
install.packages("dplyr")
library(dplyr)
#note that this is another code that should be added in every 
  #script (like ggplot)

#From workshop https://vimeo.com/418281958
  #filter to show only those who have paid for the course
Paid <- student_mat %>% filter(paid == "yes")
#output: new Paid data frame with only rows that have "yes" 
  #in paid column

#filter to show those who have a mother or father as guardian
MotherFather <- student_mat %>% 
  filter(guardian %in% c("mother", "father"))
#output: new MotherFather data frame with only rows that have 
  #"mother" or "father" in guardian column

#order the data to see mothers first
SortedData <- MotherFather %>% arrange(desc(guardian))
#output: guardian column of MotherFather data frame sorted
  #Z-A

#include only the columns of students' age, guardian, and 
  #whether they have paid
PairedDown <- student_mat %>% select(age, guardian, paid)
#output: new PairedDown data frame with only the columns
  #age, guardian, and paid

#find the mean age
MeanAge <- PairedDown %>% summarise(mean(age))
#new (single-cell) MeanAge data frame with the mean of the
  #age column; note: this could have also been done on the
  #student_math data frame, since the data is on both

#find the mean age by guardian
MeanAgeByGuardian <- PairedDown %>%
  group_by(guardian) %>%
  summarise(mean(age))
#output: new MeanAgeByGuardian data frame with mean age by 
  #guardian

#combine all the functions
Final <- student_mat %>%
  filter(guardian %in% c("mother", "father")) %>%
  filter(paid == "yes") %>%
  arrange(desc(guardian)) %>%
  group_by(guardian) %>%
  summarise(mean(age))
#output: new Final data frame with with mean age by 
  #guardian, which only includes mother and father guardians
  #who have also paid; sorted by guardian Z-A

#combine less functions
Final2 <- student_mat %>%
  filter(guardian %in% c("mother", "father")) %>%
  filter(paid == "yes") %>%
  arrange(desc(guardian))
#output: new Final2 data frame, which only includes mother 
  #and father guardians who have also paid, sorted by 
  #guardian Z-A

#combine less functions AND include less columns
Final3 <- student_mat %>%
  filter(guardian %in% c("mother", "father")) %>%
  filter(paid == "yes") %>%
  arrange(desc(guardian)) %>% 
  select(age, guardian, paid)
#output: new Final3 data frame, which only includes mother 
  #and father guardians who have also paid, sorted by 
  #guardian Z-A, with only age, guardian, and paid columns



  #Page 7 - Filtering
library(ggplot2)
library(dplyr)

#From video - NOTE: I used the myPets dataset b/c I don't
  #have the jackrabbits dataset from the video
  #filter by one type of animal
Goats <- filter(myPets, Animal == "Goat")
#output: new Goats data frame with only goat pets

#filter for pets with specific ages
PetsTwoAndTwelve <- filter(myPets, Age %in% c(2,12))
#output: new PetsTwoAndTwelve data frame that only has pets
  #that are 2 or 12 y/o


#From lesson
#filter by one type of animal
filter(myPets, Animal == "Goat")
#output: console prints the only observations from the myPets
  #data frame which include goats

#filter by one type of animal and specified ages
filter(myPets, Animal == "Goat", Age <= 2)
#output: console prints the only observation from the myPets 
  #data frame which includes a goat that's 2 or younger

#filter by weight
filter(myPets, Weight > 3)
#output: console prints the only observations from the myPets
  #data frame which include pets that weigh more than 3 lbs

#filter by specific animals
filter(myPets, Animal %in% c("Goat", "Cat", "Guinea Pig"))
#output: console prints the only observations from the myPets
  #data frame which include a goat, cat, or guinea pig

#add Skin column to data frame b/c it magically appeared in
  #the lesson examples
myPets$Skin <- c("hair", "hair", "fur", "fur", "fins", "fins")
#output: myPets data frame now has a Skin column

#filter by specific animals
filter(myPets, Animal != "Gold Fish")
#output: console prints the only observations from the myPets
  #data frame which exclude gold fish

#save that latest filter to a new data frame, then view it
mammals <- filter(myPets, Animal != "Gold Fish")
mammals
#output: new "mammals" data frame created with only the 
  #observations from the myPets data frame which exclude 
  #gold fish, then that new data frame printed in console


#from quiz - q4
#Suppose you wish to compute the median value of mpg for 
  #the cars with 4 cylinders, the median value for cars with 
  #6 cylinders, and the median value for cars with 8 
  #cylinders; cyl is the number of cylinders. Which command 
  #would do this?
#A
myPets %>% group_by(Weight) %>% 
  summarize(median.weight = median(Weight))
#output: successful

#B
myPets %>% summarize(median.weight = median(Weight)) %>% 
  group_by(Weight)
#output: error


  #Page 8 - Ordering Data
library(ggplot2)
library(dplyer)

#From video - NOTE: I used the myPets dataset b/c I don't
  #have the jackrabbits dataset from the video

#arrange data in alphabetical order
AnimalType <- arrange(myPets,Animal)
#output: a new AnimalType data frame, sorted by the Animal
  #column, in alphabetical order

#arrange data in alphabetical order
AnimalTypeDesc <- arrange(myPets,desc(Animal))
#output: a new AnimalType data frame, sorted by the Animal
  #column, in reverse alphabetical order

#filter data and arrange it
GoatNamesAlphabetical <- myPets %>%
  filter(Animal == "Goat") %>%
  arrange(Name)
#output: a new GoatNamesAlphabetical data frame, that only 
  #includes observations that have a goat, and is sorted by 
  #the Name column, in alphabetical order
  #RE


  #Page 9 - Selection & Mutation
library(ggplot2)
library(dplyr)

#From video - NOTE: I used the myPets dataset b/c I don't
  #have the jackrabbits dataset from the video

#create a new data frame with only selected variables
petsSelected <- select(myPets, Name, Animal, Age)
#output: new petsSelected data frame with only the names,
  #animal type, and ages



  #Page 10 - Grouping & Summarizing
library(ggplot2)
library(dplyr)

#From video - NOTE: I used the myPets dataset b/c I don't
  #have the jackrabbits dataset from the video

#group data by variable
PetsGrouped <- group_by(myPets, Animal)
#output: a new PetsGrouped data frame which is the same as 
  #original

#summarize data
PetsMeanWeight <- summarise(myPets, MeanWeight = mean(Weight))
#output: a new PetsMeanWeight data frame with a single cell to 
  #show average weight

#group data and summarize it by average
PetsWeightPerAnimalType <- myPets %>%
  group_by(Animal) %>%
  summarise(mean(Weight))
#output: a new PetsWeightPerAnimalType data frame with data 
    #grouped byanimal, with the average weight for each
  #NOTE: this is called a contigency table

#possibilities for summarise function
median()
sd()
min()
max()
n()

#group data and summarise it by count
PetAgesPerAnimalType <- myPets %>%
  group_by(Animal) %>%
  summarise(Age = n())
#output: new PetAgesPerAnimalType data frame with animals per 
  #age

#group by multiple variables at once
PetAgesPerAnimalTypeAndSkinType <- myPets %>%
  group_by(Animal, Skin) %>%
  summarise(Age = n())
#output: a new PetAgesPerAnimalTypeAndSkinType data frame with
    #animals and their skin types per age
  #NOTE: These results don't match the video equivalent with 
    #her different dataset and I haven't figured out why yet
  #UPDATE: I think it's b/c the dataset is too limited... 
    #testing this theory below

#Attempting to group and summarize data on a bigger dataset to
  #see if I can results like the video
StudentsAvgAgeByGenderAndFamSize <- student_mat %>%
  group_by(sex, famsize) %>%
  summarise(mean(age))
#output: SUCCESS! The size of the dataset was the only issue 
  #above

#testing if n function can be used on its own like mean can, 
  #for ex
mean(bed_hours)
n(bed_hours)
#output: Error in n(bed_hours) : unused argument (bed_hours)
  #it cannot ;)

#From lesson
#summarize data by variable
summarise(myPets, ave_age = mean(Age))
#output: console prints a single cell to show average age

#grouping and summarizing at the same time
myPets %>%
  group_by(Animal) %>%
  summarise(ave.age = mean(Age))
#output: console prints a contingency table with data grouped 
    #by animal, with the average age for each
  #NOTE: this is apparently called a "tibble" - a data frame 
    #withadditional info

#determine the # of observations (rows) that meet a certain 
  #criteria
myPets %>%
  group_by(Animal) %>%
  summarise(count = n())
#output: console prints a 4x2 tibble with the number of each 
  #animal type in myPets data frame

#group by multiple variables
myPets %>%
  group_by(Name, Animal) %>% 
  summarise(count = n())
#output: console prints a 5x3 tibble with the number of each 
  #animal by type and name



  #Page 11 - Graphing Data Grouped by Factors
library(ggplot2)
library(dplyr)

#From video
#graph data grouped by factor
ggplot(myPets, aes(x = Animal, y = Age)) +
  geom_boxplot(aes(group = Age))
#output: side-by-side boxplot of animals by age
#x will always be categorical
#y will always be continuous


#From lesson

#view morley data frame which has values of the speed of light 
    #measured by Michelson in 1879
  #The data were collected in five experiments
  #Expt column is the number of the experiment
    #in each experiment, the speed of light was measured 20 
    #times. Each measurement is called a Run
  #Run column is the number of the specific measurement
  #The measured value was the speed of light in km/sec; in 
    #the morley dataset, 299000 is subtracted from the 
    #measured value.
  #Speed column is the measured value
View(morley)
#output: data frame opened in separate tab

head(morley)
#output: first 6 obeservations/ rows printed in console

#create a box plot of this data, grouped by Expt
ggplot(morley, aes(x = Expt, y = Speed)) +
  geom_boxplot(aes(group = Expt))
#output: a beautiful, side-by-side boxplot of experiments by
  #speed

#find the mean speed for each experiment
morley %>% 
  group_by(Expt) %>% 
  summarise(mean(Speed))
#output: 5x2 tibble of morley dataset with experiments
  #grouped and summarized by average speed