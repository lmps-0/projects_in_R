# Moneyball Project

# Updated on Thu June 10 2021
# @author: lmps-0, Lucas Manassés

# In this project I tried work with some data and with the goal of trying to find replacement players 
# for the ones that Oakland Athletics team lost at the start of the off-season - During the 2001–02 offseason. 
# The Oakland A's lost three key free agents to larger market teams.

# The main goal of this project was to work with R on real data to try and derive actionable insights.

# I will be using data from Sean Lahaman's Website a very useful source for baseball statistics. 
# The documentation for the csv files is located in the readme2013.txt file.

batting <- read.csv('Batting.csv') # first dataset -> players data
#print(head(batting))

#str(batting)

# This part is called Feature Engineering
# Where I added three more statistics (those used in Moneyball)
# Formulas on Wikipedia page

# [1] Batting Average - AVG = Hits/At Base
batting$BA <- batting$H / batting$AB
tail(batting$BA,5)

# [2] On Base Percentage
batting$OBP <- (batting$H + batting$BB + batting$HBP)/(batting$AB + batting$BB + batting$HBP + batting$SF)

# [3] Slugging Percentage -> need for singles X1B column
batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR
# now Slugging Average (SLG)
batting$SLG <- ((1 * batting$X1B) + (2 * batting$X2B) + (3 * batting$X3B) + (4 * batting$HR) ) / batting$AB

# One of the Goals is to merge the Data from Batting.csv and Salaries.csv in order to perform the analysis 

# loading the salary dataset
sal <- read.csv("Salaries.csv")

#summary(batting)
#summary(sal)
# yearID starts in 1985 for sal, so only a subset of batting is actually needed.
batting <- subset(batting,yearID >= 1985)

#summary(batting)
#summary(sal)

combo <- merge(batting,sal,by=c('playerID','yearID'))

summary(combo)

# Finding data of the three lost players
lost_players <- subset(combo,playerID %in% c('giambja01','damonjo01','saenzol01'))
# Year of interest 2001
lost_players <- subset(lost_players,yearID==2001)
lost_players <- lost_players[,c('playerID','H','X2B','X3B','HR','OBP','SLG','BA','AB')] # impostant features for the analysis

# Constraints for replacing players
# - The total combined salary of the three players can not exceed 15 million dollars.
# - Their combined number of At Bats (AB) needs to be equal to or greater than the lost players.
print(paste('AB sum: ',sum(lost_players$AB)))
# - Their mean OBP had to equal to or greater than the mean OBP of the lost players
print(paste('OBP mean:',mean(lost_players$OBP)))

combo <- subset(combo,yearID == 2001)

# graphic approach: 
library(ggplot2)
ggplot(combo, aes(x=OBP,y=salary)) + geom_point(size=2)

combo <- subset(combo,salary < 15000000/3 & OBP>0)
#str(combo)

combo <- subset(combo,AB >= sum(lost_players$AB)/3)
str(combo)
#install.packages('dplyr')
library(dplyr)

options <- head(arrange(combo,desc(OBP)),10)
options[,c('playerID','AB','salary','OBP')]
