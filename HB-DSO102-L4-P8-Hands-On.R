#Create a new eruptions.times vector with eruptions column from faithful dataset
eruptions.times <- faithful$eruptions
#output: new eruptions.times vector with 272 elements


#Split the new vector into 2 new vectors: short (<= 3 min) and long (>3)
short.eruption.times <- eruption_times[eruption_times <= 3]
#output: new short.eruptions.times vector with 97 elements (per index in
#environment pane)

long.eruption.times <- eruption_times[eruption_times > 3]
#output: new long.eruptions.times vector with 175 elements (per index in
#environment pane)

#Math check to ensure all elements are represented (total elements - 
#short elements)
272 - 97
#output: 175, which = long elements, so the math works


#How many elements are in the vector short?
length(short.eruption.times)
#output: 97

#How many elements are in the vector long?
length(long.eruption.times)
#output: 175

#What is the mean eruption time of the short eruptions?
mean(short.eruption.times)
#output: 2.038134

#What is the mean eruption time of the long eruptions?
mean(long.eruption.times)
#output: 4.291303

#What is the standard deviation of the short eruption times?
sd(short.eruption.times)
#output: 0.2668655

#What is the standard deviation of the long eruption times?
sd(long.eruption.times)
#output: 0.4108516


#Attempting to get the output to read in plain English
#attempt 1
#How many elements are in the vector short?
print("There are", length(short.eruption.times), "elements in the short.eruption.times vector")
#output: Error in print.default("There are", length(short.eruption.times), 
#"elements in the short.eruption.times vector") : 
#invalid printing digits 97

#attempt 2
#How many elements are in the vector short?
cat("There are", length(short.eruption.times), "elements in the short.eruption.times vector")
#output: There are 97 elements in the short.eruption.times vector
#Success!!


#Updating all questions to have plain English responses
#How many elements are in the vector short?
cat("There are", length(short.eruption.times), "elements in the short.eruption.times vector")
#output: There are 97 elements in the short.eruption.times vector

#How many elements are in the vector long?
cat("There are", length(long.eruption.times), "elements in the long.eruption.times vector")
#output: There are 175 elements in the long.eruption.times vector

#What is the mean eruption time of the short eruptions?
cat("The mean of short.eruption.times is", mean(short.eruption.times))
#output: The mean of short.eruption.times is 2.038134

#What is the mean eruption time of the long eruptions?
cat("The mean of long.eruption.times is", mean(long.eruption.times))
#output: The mean of long.eruption.times is 4.291303

#What is the standard deviation of the short eruption times?
cat("The standard deviation of short.eruption.times is", sd(short.eruption.times))
#output: The standard deviation of short.eruption.times is 0.2668655

#What is the standard deviation of the long eruption times?
cat("The standard deviation of long.eruption.times is", sd(long.eruption.times))
#output: The standard deviation of long.eruption.times is 0.4108516