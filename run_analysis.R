##########################################################################################################  

## Coursera Getting and Cleaning Data Course Project

## The data used in the course project is data collected from the accelerometers from the Samsung Galaxy S smartphone:
## "Human Activity Recognition Using Smartphones Data Set" (UCI HAR Dataset).
## The original data is found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
## A description of the original data is found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

## This script will perform the following steps on the UCI HAR Dataset:
## 1. Merge the training and the test sets to create one dataset.
## 2. Extract only the measurements on the mean and standard deviation for each measurement.
## 3. Use descriptive activity names to name the activities in the data set.
## 4. Appropriately label the data set with descriptive activity names.
## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
##    The new tidy data set is written to a tab-delimited file called tidy.txt (created with write.table() using row.name=FALSE).

########################################################################################################## 


## Clear the workspace
rm(list=ls())

## Load in the required libraries
library(reshape2)


## 1. Merge the training and the test sets to create one dataset.


## Read in the data from the features and activity_labels files and assign column names
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, col.names = c("featureID", "feature"))
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("activityID", "Activity"))

## Read in the data from the train files and assign column names
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "Subject") 
xTrain <- read.table("./UCI HAR Dataset/train/x_train.txt", header = FALSE, col.names = features$feature)
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = "activityID")

## Read in the data from the test files and assign column names
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "Subject") 
xTest <- read.table("./UCI HAR Dataset/test/x_test.txt", header = FALSE, col.names = features$feature)
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = "activityID")

## Create the training dataset by merging subjectTrain, xTrain, and yTrain
dataTrain <- cbind(yTrain, subjectTrain, xTrain)

## Create the test dataset by merging subjectTest, xTest, and yTest
dataTest <- cbind(yTest, subjectTest, xTest)

## Merge the training and test datasets to create a single dataset
dataMerged <- rbind(dataTrain, dataTest)


## 2. Extract only the measurements on the mean and standard deviation for each measurement.


## Create a logical vector identifying the columns containing mean and standard deviation measurements from the merged dataset
## Retain Activity and Subject columns; exclude meanFreq columns
finalCols <- append(grepl("-mean|-std", features$feature, ignore.case = TRUE) 
                    & !grepl("-meanFreq", features$feature, ignore.case = TRUE), c(TRUE, TRUE), 0)

## Subset the merged dataset by the logical vector of column names, preserving only the relevant columns
dataMerged <- dataMerged[finalCols == TRUE]


## 3. Use descriptive activity names to name the activities in the dataset.

## Integrate descriptive activity names by merging the merged dataset with the activity labels dataset
## Remove the no longer necessary activityID column
dataMerged <- merge(activityLabels, dataMerged, by = "activityID", all.x = TRUE)
dataMerged <- dataMerged[,-1]
                     
                     
## 4. Appropriately label the data set with descriptive activity names.  

## Clean up the column names in the merged dataset
colnames(dataMerged) <- gsub("(\\.){2,}", "", colnames(dataMerged))
colnames(dataMerged) <- gsub("std", "stddev", colnames(dataMerged))
colnames(dataMerged) <- gsub("^(t)","time", colnames(dataMerged)) 
colnames(dataMerged) <- gsub("^(f)","freq", colnames(dataMerged)) 
colnames(dataMerged) <- gsub("Mag","Magnitude", colnames(dataMerged))
colnames(dataMerged) <- gsub("Acc","Acceleration", colnames(dataMerged))
colnames(dataMerged) <- gsub("Gyro","Gyroscope", colnames(dataMerged))
colnames(dataMerged) <- gsub("BodyBody","Body", colnames(dataMerged))
colnames(dataMerged) <- gsub("(x)$",".x", colnames(dataMerged))
colnames(dataMerged)[-(1:2)] <- gsub("(y)$",".y", colnames(dataMerged))[-(1:2)]
colnames(dataMerged) <- gsub("(z)$",".z", colnames(dataMerged))


## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
##    The new tidy data set is written to a tab-delimited file called tidy.txt (created with write.table() using row.name=FALSE).


## Summarize the merged data on the mean of each variable for each activity label and subject ID pair
dataMerged <- aggregate(dataMerged[,!(colnames(dataMerged) %in% c("Activity", "Subject"))], 
                      by = list(Activity = dataMerged$Activity, Subject = dataMerged$Subject), 
                      mean)

## Reshape the merged data to the long narrow tidy form (reording Subject and Activity and naming new columns)
dataTidy <- reshape2:::melt(dataMerged, , id.vars = c("Subject", "Activity"), variable.name = "Feature", value.name = "Mean")

## Write the tidy dataset to tab-delimited file tidy.txt in the working directory 
write.table(dataTidy, './tidy.txt', row.names = FALSE, sep = '\t')


