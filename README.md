# Getting and Cleanning Data

Author: Cesar Lugo.
Version: 1.0 .
Version release date: February 17,  .
Subject: Getting and Cleanning data, Data Science specialization, assignment.


This document describes the work created to analyze some statistical data that comes from a study 
that gathered information of some persons performing some activities while using some wearable
devices, which recorded some relevant information regarding those activities.

The final result is to obtain a dataset named (selecteddataaverages) that contains averages of
some selected data grouped by activity performed and by the subject who performed the activity.

The source data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here you can find the source data used in this project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

All data referecend heere is contained in the directory UCI HAR Dataset within the zip file.
Please note all directories referenced in this document are mentions to a relative path to that UCI HAR Dataset directory.

As explained in the the "README.txt" file, data was stored and made available to the public in multiple files. 
From those files, we used the main data, as follows:

The "test" directory contains a portion of the gathered data, used for testing hypotesis performed on the data.
The "train" directory contains another portion of the gathered data, used for some observation process leading to hypotesis creation.
- "features.txt" . I obtained from this file the variable names for each data colum of the "test/X_test.txt" and "train/X_train" file.

from each of those directories, the analysis performed in this work process uses the following files:
- "test/X_test.txt". I obtained from this file the first portion of the data set.
- "test/subject_test.txt". I obtained from this file an additional column containing the subject who performed each the activity on the "test/X_test.txt" file.
- "test/y_test.txt". I obtained from this file an additional column containing the activity code of the activity performed each the activities measured on the "test/X_test.txt" file.

- "train/X_train.txt". I obtained from this file the first portion of the data set.
- "train/subject_train.txt". I obtained from this file an additional column containing the subject who performed each the activity on the "train/X_train.txt" file.
- "train/y_train.txt". I obtained from this file an additional column containing the activity code of the activity performed each the activities measured on the "train/X_train.txt" file.

All data from the directories named "Inertial Signals" was not considered in this work, because this information was already processed by the original authors into the other files I used, sumarized above.

To obtain the full dataset, I combined the test and train data into one dataset (mergeddata), selected some of the columns containing averages and standard deviations, and performed calculation of averages for each variable grouped by activity and subject, in 5 steps, as explained in the details section below.


## Details Section

The run_analysis function contained here was created in this work.

You can find this run_anaysis function source code in this repository, with the name "run_analysis.R"

. The function does the following: 

Step 1. Merges the training and the test sets to create one data set.
Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Step 3. Uses descriptive activity names to name the activities in the data set
Step 4. Appropriately labels the data set with descriptive variable names.
Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The run_analysis is a function that receives no parameters. As a result, 
it returns an independent tidy data set with the average of each variable for each activity and each subject (selecteddataaverages).
  
Step 0: First it validates that the user who calls the function is running the script from the approporate directory. Otherwise it lets you know where you should run it.
Step 1: Merges the training and the test sets to create one data set.
    
Step 1.1: Gather test data along with the activity code and subject information 
corresponding to each sample row, and assign the corresponding variable names as column headers:
    
	Read data labels from the features.txt file, which are contained in the second column.
	Read the test data from the test/X_test.txt file, which has no column names.
	Add variable names to xtest using the second column of datalabels table.
	Read the test activity numeric codes from "test/y_test.txt" and assign a variable name.
	Add a "testactivity" column to the xtest dataset to identify the activity of each row.
	Read the subject numeric codes from "test/subject_test.txt" and assign a variable name.
	Add a "testsubject" column to the xtest dataset to identify the activity of each row.

Step 1.2: Similarly, gather train data along with the activity code and subject information 
corresponding to each sample row, and assign the corresponding variable names as column headers:
    
	Read the train data from the train/X_train.txt file, which has no column names.
	Add variable names to xtrain using the second column of datalabels table.
	Read the train activity numeric codes from "train/y_train.txt".
	Add a "trainactivity" column to the xtrain dataset to identify the activity of each row.
	Read the subject numeric codes from "train/subject_train.txt" and assign a variable name.
	Add a "trainsubject" column to the xtest dataset to identify the activity of each row.

Step 1.3 Merge the xtrain and xtest dataframes into a new mergeddata dataset.	

Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

Step 2.1 Extract those columns into a new dataset called selecteddata.
Step 2.2 Add the corresponding activity and subject columns to the selecteddata dataframe.
    
Step 3. Uses descriptive activity names to name the activities in the data set:
  
Step 3.1 First extract the corresponding labes for each activity into a dataframe called activitynames.
Step 3.2 Add a column to selecteddata dataframe with the corresponding activity name. A findmyactivityname function is used to find the activity name of a corresponding activity code
    
Step 4. Appropriately labels the data set with descriptive variable names.
Variable names in the selecteddata dataset are reanames according to the description of the features found on the features.info document, which reads as follows:
    
		"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
		Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
		Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
		These signals were used to estimate variables of the feature vector for each pattern:  
		'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. "
    
Step 4.1 Rename the time domain signals into appropriate names according to the author's description referenced above.
Step 4.2 Rename the time domain signals magnitudes into appropriate names according to the author's description referenced above.
Step 4.3 Rename the fast fourier transform domain signals into appropriate names according to the author's description referenced above.

Step 4.4 Rename the fast fourier transform domain magnitudes into appropriate names according to the author's description referenced above

Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
I have included the activity.name in addition to the activity (and subject). It does not alter the grouping, and the contents are more clear to understand.
Eliminate the last 2 columns no longer needed, which do not contain numeric average data

You can find this run_anaysis function source code in this repository, with the name "run_analysis.R"