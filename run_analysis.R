##Use these libraries
library(dplyr)
library(tidyr)

##MERGE ALL DATA INTO 1 DATABASE
##
##read all different tables and name the columns

subjectTest <- read.table("./test/subject_test.txt", stringsAsFactors = FALSE)
subjectTrain <- read.table("./train/subject_train.txt", stringsAsFactors = FALSE)
names(subjectTest) <- "subject"
names(subjectTrain) <- "subject"

x_Test <- read.table("./test/X_test.txt", stringsAsFactors = FALSE)
x_Train <- read.table("./train/X_train.txt", stringsAsFactors = FALSE)
nombres <- read.table("./features.txt", stringsAsFactors = FALSE)
names(x_Test) <- nombres[, 2]
names(x_Train) <- nombres[, 2]

y_Test <- read.table("./test/y_test.txt", stringsAsFactors = FALSE)
y_Train <- read.table("./train/y_train.txt", stringsAsFactors = FALSE)
names(y_Test) <- "activity"
names(y_Train) <- "activity"

activity <- read.table("./activity_labels.txt", stringsAsFactors = FALSE)
names(activity) <- "activity"

##combine the test and train databases

test <- cbind(subjectTest, "activity" = activity[y_Test[,], 2], x_Test)
train <- cbind(subjectTrain, "activity" = activity[y_Train[,], 2], x_Train)

##get one database from the test and train db

data <- rbind(test, train)

#create a tidy database

sub_act <- data[, 1:2]
meanData <- data[, grep("mean()", names(data))]
stdData <- data[, grep("std()", names(data))]

tidyData <- cbind(sub_act, meanData, stdData)

meltTidy <- melt(tidyData, id.vars = c("subject", "activity"))

write.table(meltTidy, "writeTable.txt", row.names = FALSE)
