##merge all the data into 1 database
##
##
##
##
##
library(dplyr)
library(tidyr)

subjectTest <- read.table("./test/subject_test.txt")
subjectTrain <- read.table("./train/subject_train.txt")
names(subjectTest) <- "subject"
names(subjectTrain) <- "subject"

x_Test <- read.table("./test/X_test.txt")
x_Train <- read.table("./train/X_train.txt")
nombres <- read.table("./features.txt")
names(x_Test) <- nombres[, 2]
names(x_Train) <- nombres[, 2]

y_Test <- read.table("./test/y_test.txt")
y_Train <- read.table("./train/y_train.txt")
names(y_Test) <- "activity"
names(y_Train) <- "activity"

activity <- read.table("./activity_labels.txt")
names(activity) <- "activity"

##test <- cbind(subjectTest, y_Test, x_Test)
##train <- cbind(subjectTrain, y_Train, x_Train)

test <- cbind(subjectTest, "activity" = activity[y_Test[,], 2], x_Test)
train <- cbind(subjectTrain, "activity" = activity[y_Train[,], 2], x_Train)

data <- rbind(test, train)

meanData <- lapply(data[, 3:dim(data)[2]], mean)
meanSd <- lapply(data[3:dim(data)[2]], sd)

results <- cbind(meanData, meanSd)
names(results) <- c("Mean", "Std Deviation")

print(head(results))