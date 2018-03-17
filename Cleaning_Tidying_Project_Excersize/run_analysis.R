##
#Getting and Cleaning Data Course Project
#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
#The goal is to prepare tidy data that can be used for later analysis. 
# The data is downloaded from the UCI Website http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##

##download the file from coursera website

library(reshape2)

filename <- "UCI_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  

##unzip the file

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

dataPath <- "UCI HAR Dataset"



