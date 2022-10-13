library(ggplot2)

#build data frame with rivers dataset (length in mi's for 141 rivers in N. America)
rr = data.frame(rivers)
#output: new data in global environment

#View beginning of new rr data frame
View(rr)
#output: opened a new tab with data frame (didn't print first 6 values, as indicated)
#sidenote: bummer not to have the Rivers labeled, I'm curious where the Columbia falls in range, since I live near it

#HISTOGRAM
#create a histogram with suitable bin widths
#create histogram with defaults
ggplot(rr, aes(x = rivers)) + geom_histogram()
#output: histogram that is skewed to the left, and thus not normally distributed; it also looks like there are some high outliers

#experiment with different bin widths... trying to determine what's "suitable"
ggplot(rr, aes(x = rivers)) + geom_histogram(binwidth = 10)
#output: tiny lines, oops!

ggplot(rr, aes(x = rivers)) + geom_histogram(binwidth = 100)
#output: not dramatically different from default

ggplot(rr, aes(x = rivers)) + geom_histogram(binwidth = 1000)
#output: aha! much different.. but maybe too different

ggplot(rr, aes(x = rivers)) + geom_histogram(binwidth = 500)
#output: still seems too compacted or something

ggplot(rr, aes(x = rivers)) + geom_histogram(binwidth = 250)
#output: maybe this is suitable? It's condensed but still has some detail

#pretty up the histogram
ggplot(rr, aes(x = rivers)) + 
  geom_histogram(binwidth = 250, fill = "#1fe0e0", color = "#369f9f") +
  ggtitle("Rivers by Length in Miles") +
  xlab("Length in Miles") +
  ylab("Count of Rivers")
#output: a labeled histogram with river-colored bars and is (still) skewed to the left, and thus not normally distributed; and still seeing likely high outliers



#BOX PLOT
#create a box plot
ggplot(rr, aes(y = rivers)) + geom_boxplot()
#output: box plot - with more outliers than I realized based on histogram


#compute outliers
#view summary info
summary(rr$rivers)
#output:
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  135.0   310.0   425.0   591.2   680.0  3710.0

#find IQR and create new variable for it
riversIqr <- 680 - 135
#output: new riversIqr variable with value: 545

#find outlier range and create another new variable
outlierRangeRivers <- riversIqr * 1.5
#output: 817.5

#find max value before outliers
680 + outlierRangeRivers
#output: 1497.5

#find min value before outliers
135 - outlierRangeRivers
#output: -682.5

#outliers: anything above 1497.5 or below -682.5


#pretty up the box plot
ggplot(rr, aes(y = rivers, x = "")) +
  geom_boxplot(fill = "#1fe0e0", color = "#369f9f") +
  ylab("Length in Miles") +
  xlab("") +
  ggtitle("Rivers by Length in Miles")
#output: a labeled box plot with river-colored data, including high outliers


#create box plot without outliers
#confirm that there are no low outliers
rr < -682.5
#output: all FALSE values, which validates what I can see visually, that there are no low outliers

#create a vector with high outliers removed
riversWithoutOutliers <- rr[rr <= 1497.5]
#output: a new vector with 135 elements (per index)

#create data frame for vector that excludes outliers
riversWithoutOutliersDf <- data.frame(Rivers = riversWithoutOutliers)

#create box plot with new data frame
ggplot(riversWithoutOutliersDf, aes(y = Rivers, x = "")) +
  geom_boxplot(fill = "#1fe0e0", color = "#369f9f") +
  ylab("Length in Miles") +
  xlab("") +
  ggtitle("Rivers by Length in Miles")
#output: new box plot, that's pretty, but maybe by being redistributed (?) still has high outliers
#not included in presentation, per this being an experiment seemingly gone awry



#NORMAL PROBABILITY PLOT
#create a normal probability plot
ggplot(rr, aes(sample = rivers)) + geom_qq()
#output: a noticeably curved (up and to the right) line which means it is not normally distributed
#results align with histogram (not normally distributed)
#results align with box plot (can visually see high outliers)

#pretty up the normal probability plot
ggplot(rr, aes(sample = rivers)) + 
  geom_qq(color = "#369f9f") +
  xlab("") +
  ylab("Length in Miles") +
  ggtitle("Rivers by Length in Miles")
#output: a labeled normal probability plot with river-colored data, that is (still) noticeably curved (up and to the right) line which means it is not normally distributed, and which (still) includes high outliers