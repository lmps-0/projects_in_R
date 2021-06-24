# Linear Regression Model

# Updated on Thu June 20 2021
# @author: lmps-0, Lucas Manassés

# In this project I used the "Bike Sharing Demand Kaggle challenge!". 
# However, I did not submit any results to the competition.

# READING DATASET -> reading bikeshare.csv file 
bike <- read.csv("bikeshare.csv")
print(head(bike))

# defining the target to predict: count column
# how many bikes rented in the particular time

# EXPLORING DATA ANALYSIS
# correlation between temp and count
library(ggplot2)
library(dplyr)
ggplot(bike,aes(temp,count)) + geom_point()
ggplot(bike,aes(temp,count)) + geom_point(alpha=0.3,aes(color=temp)) + theme_bw()

# Convert to POSIXct()
#bike$datetime <- as.POSIXct(bike$datetime)
bike$datetime <- as.POSIXct(bike$datetime, origin="2011-01-01", tz="GMT")

pl <- ggplot(bike,aes(datetime,count)) + geom_point(aes(color=temp),alpha=0.5) + scale_color_continuous(low='#55D8CE',high='#FF6E2E') + theme_bw()
print(pl)

# Correlation temp x count
cor(bike[,c('temp','count')])

ggplot(bike,aes(factor(season),count)) + geom_boxplot(aes(color=factor(season))) + theme_bw()

# FEATURE ENGINEERING
bike$hour <- sapply(bike$datetime,function(x){format(x,"%H")})
head(bike)

# Scatterplot
pl <- ggplot(filter(bike,workingday==1),aes(hour,count))

pl <- pl + geom_point(position=position_jitter(w=1, h=0),aes(color=temp),alpha=0.5)

pl <- pl + scale_color_gradientn(colours = c('dark blue','blue','light blue','light green','yellow','orange','red'))
pl <- pl + theme_bw()
print(pl) 


# BUILDING THE LINEAR REGRESSION MODEL
# Predicting count by temperature
temp.model <- lm(count ~ temp,bike)
print(summary(temp.model))

# How many bike rental counts at 25ºC ?
temp.test <- data.frame(temp=c(25))
temp.test
predict(temp.model,temp.test)

# Predicting count by many features except (casual - registered - datetime - atemp)
bike$hour <- sapply(bike$hour,as.numeric) # Feature Engineering 2

model <- lm(count ~ . - casual - registered - datetime - atemp, bike)

print(summary(model))

