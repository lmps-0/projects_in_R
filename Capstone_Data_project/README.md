# MoneyBall Project

In this project I tried to work with some data by trying to find replacement players for the ones that Oakland Athletics team lost at the start of the off-season - During the 2001–02 offseason. The Oakland A's lost three key free agents to larger market teams.

The main goal of this project was to work with R on real data to try and derive actionable insights.

I used data from Sean Lahaman's Website a very useful source for baseball statistics. 

The documentation for the csv files is located in the readme2013.txt file.

- _Batting.csv_ contains the first dataset (players data)

- _Salaries.csv_ contains the dataset of salaries

# Feature Engineering
Where I added three more statistics (those used in Moneyball)
Formulas are from Wikipedia page.

- [1] Batting Average, AVG = Hits/At Base
- [2] On Base Percentage
- [3] Slugging Percentage -> there is the need of singles, X1B column

# Constraints for replacing players
- The total combined salary of the three players can not exceed 15 million dollars.
- Their combined number of At Bats (AB) needs to be equal to or greater than the lost players.
- Their mean OBP had to equal to or greater than the mean OBP of the lost players
