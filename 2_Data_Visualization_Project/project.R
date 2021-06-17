# Updated on Mon June 7 2021
# @author: lmps-0, Lucas Manassés

# In this project I tried to recreate a plot from The Economist.
# link: https://www.economist.com/graphic-detail/2011/12/02/corrosive-corruption

# Verify the installation of required packages!

#install.packages('ggplot2') # library for plotting
#install.packages('data.table') # it makes the reading process faster -> fread()
library(ggplot2)
library(ggthemes)
library(data.table)

df <- fread('1.Economist_Data.csv',drop = 1) # importing Dataset

pl <- ggplot(df,aes(x = CPI,y = HDI,color = Region)) + geom_point(size = 4,shape = 1)

pl2 <- pl + geom_smooth(aes(group = 1),method = 'lm',formula = y~log(x),se = F,color = 'red')

# Selected countries appearing in the plot 
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                           +              data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)
pl4 <- pl3 + theme_economist_white()

pl5 <- pl4 + scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",limits = c(.9,10.5),breaks = 1:10)

pl6 <- pl5 + scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",limits = c(0.2, 1.0))

pl7 <- pl6 + ggtitle("Corruption and Human development")

print(pl7)
