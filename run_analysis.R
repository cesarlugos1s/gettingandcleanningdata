
## The run_analysis function contained here does the following: 

## Step 1. Merges the training and the test sets to create one data set.
## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## Step 3. Uses descriptive activity names to name the activities in the data set
## Step 4. Appropriately labels the data set with descriptive variable names.
## Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis <- function()
{
  
  # First it validates that you are running the script from the approporate directory. Otherwise it lets you know where you should run it.
  if ( !file.exists("test") || !file.exists("train") )
{
    stop("Invalid directory. Please move first to the directory where the test and train directories which contain the data are (typically named UCI HAR Dataset)") 
}
  # Step 1: Merges the training and the test sets to create one data set.
    
    ## Step 1.1: Gather test data along with the activity code and subject information 
    ## corresponding to each sample row, and assign the corresponding variable names as column headers
    
    ## Read data labels from the features.txt file, which are contained in the second column
    datalabels <- read.table("features.txt",colClasses = "character", header = FALSE)
    ## Read the test data from the test/X_test.txt file, which has no column names
    xtest <- read.table("test/X_test.txt", header = FALSE)
    ## Add variable names to xtest using the second column of datalabels table
    names(xtest) <- datalabels[,2]
    
    # Read the test activity numeric codes from "test/y_test.txt" and assign a variable name
    testactivity <- read.table("test/y_test.txt", header = FALSE)
    names(testactivity) <- "testactivity"
    # Add a "testactivity" column to the xtest dataset to identify the activity of each row
    xtest$activity <- testactivity$testactivity
    
    # Read the subject numeric codes from "test/subject_test.txt" and assign a variable name
    testsubject <- read.table("test/subject_test.txt", header = FALSE)
    names(testsubject) <- "testsubject"
    # Add a "testsubject" column to the xtest dataset to identify the activity of each row
    xtest$subject <- testsubject$testsubject
    
    ## Step 1.2: Similarly, gather train data along with the activity code and subject information 
    ## corresponding to each sample row, and assign the corresponding variable names as column headers
    
    ## Read the train data from the train/X_train.txt file, which has no column names
    xtrain <- read.table("train/X_train.txt", header = FALSE)
    
    ## Add variable names to xtrain using the second column of datalabels table
    names(xtrain) <- datalabels[,2]
    
    # Read the train activity numeric codes from "train/y_train.txt"
    trainactivity <- read.table("train/y_train.txt", header = FALSE)
    names(trainactivity) <- "trainactivity"
    # Add a "trainactivity" column to the xtrain dataset to identify the activity of each row
    xtrain$activity <- trainactivity$trainactivity
    
    # Read the subject numeric codes from "train/subject_train.txt" and assign a variable name
    trainsubject <- read.table("train/subject_train.txt", header = FALSE)
    names(trainsubject) <- "trainsubject"
    # Add a "trainsubject" column to the xtest dataset to identify the activity of each row
    xtrain$subject <- trainsubject$trainsubject
    
    # Merge the xtrain and xtest dataframes into a new mergeddata dataset
    mergeddata <- rbind(xtrain,xtest)

  ## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    ## Step 2.1 Extract those columns into a new dataset called selecteddata
    selecteddata <- mergeddata[,c(grep("-std\\(\\)$|-mean\\(\\)$",names(mergeddata)))]
    ## Step 2.2 Add the corresponding activity and subject columns to the selecteddata dataframe
    selecteddata$activity <- mergeddata$activity
    selecteddata$subject <- mergeddata$subject
    
  ## Step 3. Uses descriptive activity names to name the activities in the data set
  
    ## Step 3.1 First extract the corresponding labes for each activit
    ## into a dataframe called activitynames
    activitynames <- read.table("activity_labels.txt", header = FALSE)
    names(activitynames) <- c("activity","activityname")
    ## Step 3.2 Add a column to selecteddata dataframe with the corresponding activity name
    # This findmyactivityname function is used to find the activity name of a corresponding activity code
    findmyactivityname <- function (activitycode)
    {
      activitynames[activitynames$activity == activitycode,"activityname"]
    }
    selecteddata$activity.name <- sapply(selecteddata$activity,findmyactivityname)
    
  ## Step 4. Appropriately labels the data set with descriptive variable names.
    # Variable names in the selecteddata dataset are reanames according to the 
    # description of the features found on the features.info document, which reads as follows:
    
    # "The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
    # Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
    # Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
    # These signals were used to estimate variables of the feature vector for each pattern:  
    #   '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. "
    
    #Step 4.1 Rename the time domain signals into appropriate names according to the author's description referenced above
    names(selecteddata) <- gsub("tBodyAcc-","time.body.accelerometer.signal.", names(selecteddata))
    names(selecteddata) <- gsub("tGravityAcc-","time.gravity.accelerometer.signal.", names(selecteddata))
    names(selecteddata) <- gsub("tBodyAccJerk-","time.body.accelerometer.jerk.signal.", names(selecteddata))
    names(selecteddata) <- gsub("tBodyGyro-","time.body.gyroscope.signal.", names(selecteddata))
    names(selecteddata) <- gsub("tBodyGyroJerk-","time.body.gyroscope.jerk.signal.", names(selecteddata))

    #Step 4.2 Rename the time domain signals magnitudes into appropriate names according to the author's description referenced above
    names(selecteddata) <- gsub("tBodyAccMag-","time.body.accelerometer.magnitude.", names(selecteddata))
    names(selecteddata) <- gsub("tGravityAccMag-","time.gravity.accelerometer.magnitude.", names(selecteddata))
    names(selecteddata) <- gsub("tBodyAccJerkMag-","time.body.accelerometer.jerk.magnitude.", names(selecteddata))
    names(selecteddata) <- gsub("tBodyGyroMag-","time.body.gyroscope.magnitude.", names(selecteddata))
    names(selecteddata) <- gsub("tBodyGyroJerkMag-","time.body.gyroscope.jerk.magnitude.", names(selecteddata))
    
    #Step 4.3 Rename the fast fourier transform domain signals into appropriate names according to the author's description referenced above
    names(selecteddata) <- gsub("fBodyAcc-","fast.fourier.transform.body.accelerometer.signal.", names(selecteddata))
    names(selecteddata) <- gsub("fGravityAcc-","fast.fourier.transform.gravity.accelerometer.signal.", names(selecteddata))
    names(selecteddata) <- gsub("fBodyAccJerk-","fast.fourier.transform.body.accelerometer.jerk.signal.", names(selecteddata))
    names(selecteddata) <- gsub("fBodyGyro-","fast.fourier.transform.body.gyroscope.jerk.signal.", names(selecteddata))
    names(selecteddata) <- gsub("fBodyGyroJerk-","fast.fourier.transform.body.gyroscope.jerk.signal.", names(selecteddata))

    #Step 4.4 Rename the fast fourier transform domain magnitudes into appropriate names according to the author's description referenced above
    names(selecteddata) <- gsub("fBodyAccMag-","fast.fourier.transform.body.accelerometer.magnitude.", names(selecteddata))
    names(selecteddata) <- gsub("fGravityAccMag-","fast.fourier.transform.gravity.accelerometer.magnitude.", names(selecteddata))
    names(selecteddata) <- gsub("fBodyAccJerkMag-","fast.fourier.transform.body.accelerometer.jerk.magnitude.", names(selecteddata))
    names(selecteddata) <- gsub("fBodyGyroMag-","fast.fourier.transform.body.gyroscope.jerk.magnitude.", names(selecteddata))
    names(selecteddata) <- gsub("fBodyGyroJerkMag-","fast.fourier.transform.body.gyroscope.jerk.magnitude.", names(selecteddata))

    names(selecteddata) <- gsub("fBodyBodyAccJerkMag-","fast.fourier.transform.body.body.accelerometer.jerk.magnitude.", names(selecteddata))
    names(selecteddata) <- gsub("fBodyBodyGyroMag-","fast.fourier.transform.body.body.gyroscope.magnitude.", names(selecteddata))
    names(selecteddata) <- gsub("fBodyBodyGyroJerkMag-","fast.fourier.transform.body.body.gyroscope.jerk.magnitude.", names(selecteddata))

    ## Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    # I have included the activity.name in addition to the activity (and subject). It does not alter the grouping, and the contents are more clear to understand.
    selecteddataaverages <- aggregate(selecteddata[,1:ncol(selecteddata)-1],by = list(activity = selecteddata$activity, activity.name = selecteddata$activity.name, subject = selecteddata$subject), FUN = "mean")   
    # Eliminate the last 2 columns no longer needed, which do not contain numeric average data
    selecteddataaverages <- selecteddataaverages[,1:(ncol(selecteddataaverages)-2)]
    selecteddataaverages
}