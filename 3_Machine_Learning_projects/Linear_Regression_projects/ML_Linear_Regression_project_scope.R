# 14.06.2021

# Linear Regression
# Student Performance dataset
df <- read.csv('student-mat.csv',sep = ';') # when it's not separate by ','

summary(df)

any(is.na(df))

library(ggplot2)
library(ggthemes)
library(dplyr)

# Num only
num.cols <- sapply(df, is.numeric)
# filter
cor.data <- cor(df[,num.cols])
print(cor.data)

#install.packages('corrgram')
library(corrgram)
#install.packages('corrplot')
library(corrplot) # only numeric features -> filter is needed

print(corrplot(cor.data,method = 'color'))

corrgram(df) # all possibilities -> help("corrgram")

corrgram(df,order=TRUE, lower.panel=panel.shade,upper.panel=panel.pie, text.panel=panel.txt)

ggplot(df,aes(x=G3)) + geom_histogram(bins=20,alpha=0.5,fill='blue')

# ML part
# Split Data into Train and Test set
#install.packages('caTools')
library(caTools)
# Set A Seed
set.seed(101)
# Split up sample -> G3 is the label, but it works for any column
sample <- sample.split(df$G3,SplitRatio = 0.7)
# 70% of data goes to training
train <- subset(df,sample == TRUE)
# 30% will be test data
test <- subset(df,sample == FALSE)

# Model linear model function

# model <- lm(y ~ x1 + x2, data) #
# model <- lm(y ~. , data) # all features

# TRAIN and BUILD MODEL
model <- lm(G3 ~ ., data = train)

# Run Model

# Interpretate the model
print(summary(model))

res <- residuals(model)
class(res)
res <- as.data.frame(res)
head(res)

ggplot(res,aes(res)) + geom_histogram(fill='blue',alpha=0.5)

plot(model) # for analysis -> gives 4 plots

# PREDICTIONS
G3.predictions <- predict(model,test)

results <- cbind(G3.predictions,test$G3)
colnames(results) <- c('predicted','actual')
results <- as.data.frame(results)

print(head(results))

# TAKE CARE OF NEG VALUES
to_zero <- function(X){
  if (X < 0){
    return(0)
  }else{
    return(X)
  }
}

# APPLY ZERO FUNCTION
results$predicted <- sapply(results$predicted, to_zero)

## MEAN SQUARED ERROR
mse <- mean( (results$actual - results$predicted)^2)
print('MSE')
print(mse)

# RMSE
print('Squared Rooot of MSE')
print(mse^0.5)

####
SSE <- sum( (results$actual - results$predicted)^2)
SST <- sum( (mean(df$G3) - results$actual)^2)

R2 <- 1 - SSE/SST
print('R2')
print(R2)

