# CourseProject1
Course project belonging to the course Getting and Cleaning Data

The script run_analysis.R (written in R version 3.1.3) is designed to independently read, re-order, analyse and save the Human Activity Recognition Using Smartphones Dataset. The script contains several steps which are described in this readme file.

## Load data
In the first step the data is loaded into R. The data set contains of a test and a training data set. Both these data sets consist of three separate files: X_dataset.txt, Y_dataset.txt and subject_dataset.txt (where dataset is either test or train). The files are loaded into R and stored in the variables datasetDataX, datasetDataY and datasetDataSubject.

## Appropriately label the data set with descriptive variable names
The variable names are stored in a txt-file (features.txt). This file is loaded into R. The data.table library is loaded into R to be able to use the setnames function. The setnames function changes the names of the variable names. The variable names of datasetDataX are set to the variable names from the features txt-file. The name of datasetDataY and datasetDataSubject variables are set to "Activity" and "Subject", respectively.

## Merge the training and the test sets to create one data set
First, datasetDataY ("Activity") and datasetDataX (variables) are merged using the cbind function. Second, the new datasetData is merged with the datasetDataSubject variable. The datasetDataX, datasetDataY and datasetDataSubject variables are removed from R. An additional column is added to the exising data sets to distinguish between the test and training data sets. In the last step, the training and test data sets are merged into a new variable data, using the rbind function. The individual data sets are removed from R.

## Use descriptive activity names to name the activities in the data set
The activity labels are stored in a txt-file (activity_labels.txt). This file is loaded into R. A for-loop is used to change the numerical representations of the activities (1-6) with the descriptive activity labels (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

## Extract only the measurements on the mean and standard deviation for each measurement
A new logical variable (indexSubset) is created which uses a pattern matching function (grepl) to find variable names containing std (standard deviation) and mean. The first three cells of the indexSubset variable are also set to TRUE to include the first three columns of the data set ("Dataset", "Subject", "Activity") as well. The data variable containing all the data is subsetted into the dataSubset variable using the indexSubset variable. The old data is removed from R.

## Create an independent tidy data set with the average of each variable for each activity and each subject
An emtpy data frame (dataAverage) is created with the number of rows equal to the number of subjects (30) times the number of activities (6). The names of the columns are changed to "Subject", "Activity" and the names of the variables containing mean and standard deviation. A multiple for-loop finds the data belonging to each subject and activity and calculates the mean. The data is stored in dataAverage.

## Write txt file with the average data set
The new data set is written to the file dataAverage.txt, using comma seperation.