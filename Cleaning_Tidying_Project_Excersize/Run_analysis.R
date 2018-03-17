##
#Getting and Cleaning Data Course Project
#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
#The goal is to prepare tidy data that can be used for later analysis. 
# The data is downloaded from the UCI Website http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##

##download the file from coursera website

library(reshape2)
library(dplyr)

filename <- "UCI_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}

##unzip the file

if (!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

dataPath <- "UCI HAR Dataset"

# Read all the training data

training_Subjects <- read.table(file.path(dataPath, "train", "subject_train.txt"))
training_Values <- read.table(file.path(dataPath, "train", "X_train.txt"))
training_Activity <- read.table(file.path(dataPath, "train", "y_train.txt"))

# dim(training_Subjects)
# dim(training_Values)
# dim(training_Activity)

# Read all the test data
test_Subjects <- read.table(file.path(dataPath, "test", "subject_test.txt"))
test_Values <- read.table(file.path(dataPath, "test", "X_test.txt"))
test_Activity <- read.table(file.path(dataPath, "test", "y_test.txt"))

# dim(test_Subjects)
# dim(test_Values)
# dim(test_Activity)

features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)


#replace with valid column name
activities <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")

# concatenate individual data tables to make single data table
human_Activity <- rbind(
  cbind(training_Subjects, training_Values, training_Activity),
  cbind(test_Subjects, test_Values, test_Activity)
)

#replace the column name with feature names
colnames(human_Activity) <- c("subject", features[, 2], "activity")

# determine columns of data set to keep based on column name...
columnsToKeep <- grepl("subject|activity|mean|std", colnames(human_Activity))

# ... and keep data in these columns only
human_Activity <- human_Activity[, columnsToKeep]


#View(activities)
#replace with factor value
human_Activity$activity <- factor(human_Activity$activity, 
                                 levels = activities[, 1], labels = activities[, 2])

humanActivityCols <- colnames(human_Activity)

# remove special characters
humanActivityCols <- gsub("[\\(\\)-]", "", humanActivityCols)

#expand the column name
humanActivityCols <- gsub("Acc", "Accelerometer", humanActivityCols)
humanActivityCols <- gsub("Gyro", "Gyroscope", humanActivityCols)
humanActivityCols <- gsub("Mag", "Magnitude", humanActivityCols)
humanActivityCols <- gsub("Freq", "Frequency", humanActivityCols)
humanActivityCols <- gsub("mean", "Mean", humanActivityCols)
humanActivityCols <- gsub("std", "StandardDeviation", humanActivityCols)

colnames(human_Activity) <- humanActivityCols

# use group in dplyr package
#mean to summarize
humanActivityMeans <- human_Activity %>% 
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

# write the table to the file tidy_data.txt
write.table(humanActivityMeans,file = "tidy_data.txt",row.names = FALSE,quote = FALSE)