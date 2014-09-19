#Readme: Getting and Cleaning Data Course Project

##Introduction

This repository contains my work for the Coursera "Getting and Cleaning Data" course project, part of the Data Science Specialization. The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The project submission includes:

1. A tidy dataset called **tidy.txt** in tab-delimited format as described below (uploaded to the Coursera project submission page).
2. A script called **run_analysis.R** for generating a tidy dataset from the source data and outputing the result to tidy.txt.
3. A code book called **CodeBook.md** that describes the variables, the data, and any transformations or work performed to clean up the data.
4. This **README.md** file explaining how all of the scripts work and how they are connected.

##The original data source

The data for this course project is based on data collected from the accelerometers from the Samsung Galaxy S smartphone and is from the **Human Activity Recognition Using Smartphones Data Set (UCI HAR Dataset)**. 

* The original data is found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 
* A description of the original data is found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

##The script

The script **run_analysis.R** works with the data as follows:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set from the data set created in step 4. The new tidy data set contains the average of each variable for each activity and each subject. The data set is written to a tab-delimited file called **tidy.txt** and has been uploaded to the Coursera project submission page.

##The tidy data set

After running the script **run_analysis.R**, the resulting dataset is written to a tab-delimited file called **tidy.txt** located in the working directory. This dataset is in the long narrow tidy form and meets the criteria for tidy data by Hadley Wickham.

##The code book

The code book called **CodeBook.md** describes the variables, the data, and any transformations or work performed to clean up the data. Refer to **CodeBook.md** for more information.

##Loading the data and running the script

###Assumptions

1. The data source has been downloaded and saved to the local hard drive.
2. The data source has been extracted.
3. The data source is located in the **UCI HAR Dataset** subfolder of the working directory.
4. The script **run_analysis.R** is located in the working directory.
5. The necessary libraries have been installed in the R environment (see **Dependencies**).

###Dependencies

The script run_analysis.R depends on the following libraries: **reshape2**.

###Reading in the data

1. Download the source data from the **Human Activity Recognition Using Smartphones Data Set (UCI HAR Dataset)**.
2. Unzip the dataset to the subfolder **UCI HAR Dataset** in the working directory.
3. Ensure the following files exist in the **UCI HAR Dataset** subfolder:
  * activity_labels.txt
  * features.txt
  * /train/subject_train.txt
  * /train/X_train.txt
  * /train/y_train.txt
  * /test/subject_test.txt
  * /test/X_test.txt
  * /test/y_test.txt
4. Run the **run_analysis.R** script from the working directory.
5. Read in all of the source data files with the **read.table()** function
  