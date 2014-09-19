#Code Book: Getting and Cleaning Data Course Project

This code book describes the data, the variables, and any transformations or work performed to clean up the data.

---

##Description of the original data source

The tidy dataset produced by the script **run_analysis.R** is derived from the **Human Activity Recognition Using Smartphones Data Set (UCI HAR Dataset)**.

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Description of the original data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

**From the UCI HAR Dataset README.txt:**

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the UCI HAR Dataset **README.txt** file for further details about this dataset. 

---

##Preparation and transformations on the data source

**1. Obtain the source dataset and prepare R.**
  1. Download the source data from the "Human Activity Recognition Using Smartphones Data Set" (UCI HAR Dataset).
  2. Unzip the dataset to the subfolder "UCI HAR Dataset" in the working directory.
  3. Ensure the following files exist in the "UCI HAR Dataset" subfolder:
    * activity_labels.txt
    * features.txt
    * /train/subject_train.txt
    * /train/X_train.txt
    * /train/y_train.txt
    * /test/subject_test.txt
    * /test/X_test.txt
    * /test/y_test.txt 
  4. Install the reshape2 R package if necessary.
  5. Run the run_analysis.R script from the working directory.

**2. Merge the training and the test sets to create one data set.**
  1. Read in all of the source data files with the read.table() function and assign column names:
    * features       <-  features.txt
    * activityLabels <-  activity_labels.txt
    * subjectTrain   <-  subject_train.txt
    * xTrain         <-  x_train.txt (use features[,2] as column names)
    * yTrain         <-  y_train.txt
    * subjectTest    <-  subject_test.txt
    * xTest          <-  x_test.txt (use features[,2] as column names)
    * yTest          <-  y_test.txt
  2. Create the training dataset "dataTrain" by merging subjectTrain, xTrain, and yTrain using column bind.
  3. Create the test dataset "dataTest" by merging subjectTest, xTest, and yTest using column bind.
  4. Merge the training and test datasets using row bind to create a single dataset "dataMerged".

**3. Extract only the measurements on the mean and standard deviation for each measurement.**

  Assumption: Mean and standard deviation columns of interest end with either .mean or .std; the meanFreq columns are excluded.
  1. Create a logical vector using grepl to indicate columns to retain (Subject, Activity, and mean and standard deviation columns). 
  2. Subset "dataMerged" by the logical vector of column names. 

**4. Use descriptive activity names to name the activities in the data set.**

  Merge the activity labels into "dataMerged" by the activityID column and remove the now obsolete activityID column.

**5. Appropriately label the data set with descriptive variable names.**

  Clean up the column names in "dataMerged", removing unecessary spaces and expanding on some abbreviations:
  * std = stddev
  * t = time
  * f = freq
  * Mag = Magnitude
  * Acc = Acceleration
  * Gyro = Gyroscope  
  * BodyBody = Body

**6. Create a second, independent tidy data set from the data set created in step 4. The new tidy data set contains the average of each variable for each activity and each subject. The data set is written to a tab-delimited file called tidy.txt and has been uploaded to this repository.**
  1. Summarize "dataMerged" on the mean of each variable for each activity label and subject ID pair
  2. Reshape "dataMerged" with melt to transform the data into the long narrow form of tidy data and move the Subject column to the first position
  4. Write the tidy dataset to tab-delimited file tidy.txt in the working directory 

---

##Tidy dataset variables
The variables of the tidy dataset are listed in order of occurence.

###Subject
Each row identifies the subject who performed the activity, ranging from 1 to 30 (categorical integer).

###Activity
The activity label for the activity performed by each subject (categorical factor):

* LAYING 
* SITTING
* STANDING
* WALKING
* WALKING_DOWNSTAIRS
* WALKING_UPSTAIRS

###Feature
The feature measurements come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ (categorical factor):

  * timeBodyAcceleration.meanX
	* timeBodyAcceleration.meanY
	* timeBodyAcceleration.meanZ
	* timeBodyAcceleration.stddevX
	* timeBodyAcceleration.stddevY
	* timeBodyAcceleration.stddevZ
	* timeGravityAcceleration.meanX
	* timeGravityAcceleration.meanY
	* timeGravityAcceleration.meanZ
	* timeGravityAcceleration.stddevX
	* timeGravityAcceleration.stddevY
	* timeGravityAcceleration.stddevZ
	* timeBodyAccelerationJerk.meanX
	* timeBodyAccelerationJerk.meanY
	* timeBodyAccelerationJerk.meanZ
	* timeBodyAccelerationJerk.stddevX
	* timeBodyAccelerationJerk.stddevY
	* timeBodyAccelerationJerk.stddevZ
	* timeBodyGyroscope.meanX
	* timeBodyGyroscope.meanY
	* timeBodyGyroscope.meanZ
	* timeBodyGyroscope.stddevX
	* timeBodyGyroscope.stddevY
	* timeBodyGyroscope.stddevZ
	* timeBodyGyroscopeJerk.meanX
	* timeBodyGyroscopeJerk.meanY
	* timeBodyGyroscopeJerk.meanZ
	* timeBodyGyroscopeJerk.stddevX
	* timeBodyGyroscopeJerk.stddevY
	* timeBodyGyroscopeJerk.stddevZ
	* timeBodyAccelerationMagnitude.mean
	* timeBodyAccelerationMagnitude.stddev
	* timeGravityAccelerationMagnitude.mean
	* timeGravityAccelerationMagnitude.stddev
	* timeBodyAccelerationJerkMagnitude.mean
	* timeBodyAccelerationJerkMagnitude.stddev
	* timeBodyGyroscopeMagnitude.mean
	* timeBodyGyroscopeMagnitude.stddev
	* timeBodyGyroscopeJerkMagnitude.mean
	* timeBodyGyroscopeJerkMagnitude.stddev
	* freqBodyAcceleration.meanX
	* freqBodyAcceleration.meanY
	* freqBodyAcceleration.meanZ
	* freqBodyAcceleration.stddevX
	* freqBodyAcceleration.stddevY
	* freqBodyAcceleration.stddevZ
	* freqBodyAccelerationJerk.meanX
	* freqBodyAccelerationJerk.meanY
	* freqBodyAccelerationJerk.meanZ
	* freqBodyAccelerationJerk.stddevX
	* freqBodyAccelerationJerk.stddevY
	* freqBodyAccelerationJerk.stddevZ
	* freqBodyGyroscope.meanX
	* freqBodyGyroscope.meanY
	* freqBodyGyroscope.meanZ
	* freqBodyGyroscope.stddevX
	* freqBodyGyroscope.stddevY
	* freqBodyGyroscope.stddevZ
	* freqBodyAccelerationMagnitude.mean
	* freqBodyAccelerationMagnitude.stddev
	* freqBodyAccelerationJerkMagnitude.mean
	* freqBodyAccelerationJerkMagnitude.stddev
	* freqBodyGyroscopeMagnitude.mean
	* freqBodyGyroscopeMagnitude.stddev
	* freqBodyGyroscopeJerkMagnitude.mean
	* freqBodyGyroscopeJerkMagnitude.stddev

###Mean
Arithmetic mean calculation of each feature measurement for each activity subject pair. Values are normalized and bounded within [-1,1].