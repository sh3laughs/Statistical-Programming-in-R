#DSO102 - Statistical Programming in R
  #Lesson 3 - Variables, Functions, and For Loops


  #Page 2 - A Note About Errors

#Variable Naming Rules

#A - Z
#0 -9
#periods
#underscores _

valid_variable_name <- 721
valid.variable.name = 720
719 -> ValidVariableName

valid_variable_name
valid.variable.name
ValidVariableName

valid_variable_name <- 721
valid.variable.name = 720
719 -> ValidVariableName
validvariablename <- 718

valid_variable_name
valid.variable.name
ValidVariableName
validvariablename


  #Page 3 - Strings
Bison <- "Can run up to 30mph"
Bison
print (Bison)

Bison2 <- "and can also throw people up to 20 feet in the air"
Bison2

print(Bison)
print(Bison2)

paste(Bison,Bison2)

print("Hello World!")
h <- "Hello World!"
h
print(h)

f <- "Hello"
g <- "World!"
paste(f, g)


  #Page 4 - Arithmetic Operations
2+1

Two <- 2
One <- 1

Two + One
Two+One
Two-One
Two/One
Two^One
Two - One
Two / One
Two ^ One

2 + 1 * 7
(2 + 1) * 7

2+3

x <- 4
y <- 7
x + y

3^4 * 2 + 1
3 ^ (4 * 2 + 1)
4 ^ 2 + 3 ^ 2
s <- 4 ^ 2 + 3 ^ 2
s

x <- 169.0
mu <- 159.0
sigma <- 4.9

(x - mu) / sigma

x - mu / sigma


#quiz below

#question 1
r <- 2.54
pi(r ^ 2)
pi * (r ^ 2)

#question 2
0.834 ^ 2

#question 3
x <- 154.8
mu <- 159.0
sigma <- 4.9
x - mu / sigma
(x - mu) / sigma



  #Page 5 - Functions
#Pseudo coding = pretending to code, with content that won't 
  #actually work to do anything

Clean_kitchen(Steve, dishes=TRUE)

#square root function
sqrt(24)


z_score = 2.2
pnorm(z_score)

sqrt(16)

t <- sqrt(16)
t

w <- 2
sqrt(w)

x <- 472
mu <- 440
sigma <- 23
z.score <- (x - mu) / sigma
z.score

z-score <- (x - mu) / sigma
z-score

pnorm(z.score)

pnorm(z.score) * 100

pnorm(z.score, lower.tail = FALSE)
pnorm(z.score, lower.tail = FALSE) * 100

pnorm(472, mean=440, sd=23)
pnorm(472, mean=440, sd=23, lower.tail = FALSE)

#quiz below - question 3
sqrt(6.28)


  #Page 6 - Creating Functions
#From video
TspToTbsp <- function(TspTb){
  (TspTb / 3)
}

TspToTbsp(9)

#From lesson
f_to_c <- function(TF){
  (TF -32) * (5/9)
}

temp_in_c <- f_to_c(73)


  #Page 7 - Introduction to Vectors
#From video
sleep_hours <- c(7,4,8,9,5,11)
sleep_hours

sleep_hours2 <- 6:10

sleep_hours3 <- 10:6

#From lesson
c(171, 192, 183, 177, 154, 176)
171:176
heights <- c(171, 192, 183, 177, 154, 176)

1:10
7:2

s <- 2:5
s


  #Page 8 - The For Loop
#From video
#pseudo code
for(page in book){
  read(page)
}

#real code
for(number in sleep_hours){
  print(number)
}

for(number in sleep_hours){
  cat(number)
}

for(number in sleep_hours){
  cat(number, "\n")
}


TspToTbsp <- function(TspTb){
  (TspTb / 3)
}

Tsp <- c(1,5,2,11,12)

#Below means: for the number in your vector named Tsp, 
  #create a new vector named Tbsp - on the number in 
  #Tsp's, using the function TspToTbsp; and then 
  #catenate it all together, with the number of Tsp's, 
  #labeled, then the number of Tbsp's it is now, 
  #labeled, each conversion on a separate line
for(number in Tsp){
  Tbsp <- TspToTbsp(number)
  cat(number,"Tsp is", Tbsp, "Tbsp", "\n")
}

for(number in Tsp){
  Tbsp <- TspToTbsp(number)
  cat(number,"Tsp is", Tbsp, "Tbsp")
}

#From lesson
#pseudo code
for flour_cups in bowl
scoop until flour_cups=4

#real code
for (n in 1:6){
  print(n)
}

for (n in 1:6){
  print(n)
  print(n^2)
}

for (n in 1:6){
  cat(n)
  cat(n^2)
}

for (n in 1:6){
  cat(n, " ")
  cat(n^2, "\n")
}

for (n in 1:6){
  cat(n)
  cat(n^2, "\n")
}

f_to_c <- function(TF){
  (TF -32) * (5/9)
}

f_temps <- c(-40, 0, 32, 100, 212, 400)
for (f in f_temps) {
  c <-f_to_c(f)
  cat(f, " ", c, "\n")
}


  #Page 10 - Hands-On Workshop
#From workshop video
#create vector named lollipopRadius with the radii
lollipopRadius = c(2, 4, 6, 8, 10)

#create function named RtoC to calculate circumferences from the 
  #radii "lollipop" in function is a single lollipop's radius
RtoC = function(lollipop){2 * (pi * lollipop)}

#test the RtoC function with random values
RtoC(3)
RtoC(5)
RtoC(7)

#create a for loop to compute the vector
  #"circ" in for loop is a new variable for each radius' 
  #computation
for (lollipop in lollipopRadius) {
  circ = RtoC(lollipop)
  print(circ)
}

#create a for loop to compute and label the vector
for (lollipop in lollipopRadius) {
  circ = RtoC(lollipop)
  cat(lollipop, "radius =", circ, "circumference")
}

#create a for loop to compute and label the vector in separate 
  #lines (options)
for (lollipop in lollipopRadius) {
  circ = RtoC(lollipop)
  cat(lollipop, "radius =", circ, "circumference","\n")
}

for (lollipop in lollipopRadius) {
  circ = RtoC(lollipop)
  cat(lollipop, "radius =", circ, "circumference\n")
}

for (lollipop in lollipopRadius) {
  circ = RtoC(lollipop)
  cat("for a lollipop with a ", lollipop, "radius =", circ, 
      "circumference\n")
}

for (lollipop in lollipopRadius) {
  circ = RtoC(lollipop)
  cat("for a lollipop with a", lollipop, "radius =", circ, 
      "circumference\n")
}