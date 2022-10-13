#ORIGINAL!! See UPDATED below
## create vector named sphere with the weights
sphereWeight = c(0.96, 1.51, 2.17, 3.85, 4.45, 6.02)

# create function named diam to convert the weights to diameters
# "lollipop" in function is a single lollipop's radius
diam = function(sphere){
  (2 / 2.54) * (sphere / (0.92 * (4/3) * pi))
}

# test the diam function by choosing one weight with the function
# and one weight manually computed
diam(0.96)
(2 / 2.54) * (0.96 / (0.92 * (4/3) * pi))

# create a for loop to convert the vector
# "diameter" in for loop is a new variable for each weight's conversion
for (sphere in sphereWeight) {
  diameter = diam(sphere)
  print(diameter)
}

# create a for loop to convert and label the vector in separate lines
for (sphere in sphereWeight) {
  diameter = diam(sphere)
  cat("For an ice sphere with a", sphere, "radius, the circumference is", diameter, "\n")
}


#UPDATED - Ogo reached out for help, and in helping her I discovered that I had 
  #missed part of the formula for a diameter for the exponent
#NO CHANGE create vector named sphere with the weights
sphereWeight = c(0.96, 1.51, 2.17, 3.85, 4.45, 6.02)

#UPDATED create function named diam to convert the weights to diameters
  #"lollipop" in function is a single lollipop's radius
diam = function(sphere){
  (2/2.54) * ((sphere / (0.92 * (4/3) * pi)) ^ (1/3))
}

#UPDATED test the diam function by choosing one weight with the function
  #and one weight manually computed
diam(0.96)
(2 / 2.54) * ((0.96 / (0.92 * (4/3) * pi)) ^ (1/3))

#NO CHANGE create a for loop to convert the vector
  #"diameter" in for loop is a new variable for each weight's conversion
for (sphere in sphereWeight) {
  diameter = diam(sphere)
  print(diameter)
}

#NO CHANGE create a for loop to convert and label the vector in separate lines
for (sphere in sphereWeight) {
  diameter = diam(sphere)
  cat("For an ice sphere with a", sphere, "radius, the circumference is", diameter, "\n")
}