# This script provides a data pre processing template for machine learning models
# The dataset used here is from a retail company, which shows the data of 10 
# customers and whether they bought the company's product or no
#-------------------------------------------------------------------------------
# 1. Set working directory, import the libraries and the dataset
dataset = read.csv("Data.csv")
#-------------------------------------------------------------------------------
# 2. Take care of missing data

# The 'Salary' and 'Age' columns have one missing value. We will replace the missing value 
# with the mean of the 'Salary' column

# replace missing value with average for 'Age' column
dataset$Age = ifelse(is.na(dataset$Age),
                     ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Age)

# replace missing value with average for 'Salary' column
dataset$Salary = ifelse(is.na(dataset$Salary),
                     ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Salary)
#-------------------------------------------------------------------------------
# 3. Encode categorical data

# 'Country' column has categories. We need to encode these categories into 
# numbers, so that machine learning models can interpret the data

# encode 'Country' column
dataset$Country = factor(dataset$Country,
                         levels = c('France', 'Spain', 'Germany'),
                         labels = c(1, 2, 3))

# encode 'Purchased' column
dataset$Purchased = factor(dataset$Purchased,
                         levels = c('No', 'Yes'),
                         labels = c(0, 1))
#-------------------------------------------------------------------------------
# 4. Split the dataset into  training and test set

# load caTools library
library(caTools)

# set seed
set.seed(123)

# split the dependent variable where 80% goes to training set and rest to test
split = sample.split(dataset$Purchased, SplitRatio = 0.8)

# use the split to make training and test sets
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
#-------------------------------------------------------------------------------
# 5. Feature Scaling

# use feature scaling only on numeric columns
training_set[, 2:3] = scale(training_set[, 2:3])
test_set[, 2:3] = scale(test_set[, 2:3])
