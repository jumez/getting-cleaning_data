##Use these libraries
library(dplyr)
library(tidyr)

##MERGE ALL DATA INTO 1 DATABASE
##
##read all different tables and name the columns

subjectTest <- tbl_df(read.table("./test/subject_test.txt", stringsAsFactors = FALSE))
subjectTrain <- tbl_df(read.table("./train/subject_train.txt", stringsAsFactors = FALSE))
names(subjectTest) <- "subject"
names(subjectTrain) <- "subject"

x_Test <- tbl_df(read.table("./test/X_test.txt", stringsAsFactors = FALSE))
x_Train <- tbl_df(read.table("./train/X_train.txt", stringsAsFactors = FALSE))
nombres <- read.table("./features.txt", stringsAsFactors = FALSE)
names(x_Test) <- nombres[, 2]
names(x_Train) <- nombres[, 2]

y_Test <- tbl_df(read.table("./test/y_test.txt", stringsAsFactors = FALSE))
y_Train <- tbl_df(read.table("./train/y_train.txt", stringsAsFactors = FALSE))
names(y_Test) <- "activity"
names(y_Train) <- "activity"

activity <- tbl_df(read.table("./activity_labels.txt", stringsAsFactors = FALSE))
names(activity) <- "activity"

##combine the test and train databases

test <- cbind(subjectTest, "activity" = activity[y_Test, 2], x_Test)
train <- cbind(subjectTrain, "activity" = activity[y_Train, 2], x_Train)

##get one database from the test and train db

data <- rbind(test, train)

#calculate the mean and sd of the different experiments

meanData <- lapply(data[, 3:dim(data)[2]], mean)
meanSd <- lapply(data[3:dim(data)[2]], sd)

#combine the calculus and name the columns properly

results <- cbind(meanData, meanSd)
names(results) <- c("Mean", "Std Deviation")


