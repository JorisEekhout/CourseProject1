## Set working directory, the working directory should contain the folder "UCI HAR Dataset" containing the 
## Human Activity Recognition Using Smartphones Dataset
setwd("d:/personal/courses/data science/3. getting and cleaning data/course project/")

## Load data
# load the test data set
testDataX <- read.table("UCI HAR Dataset/test/X_test.txt")
# load the activities from the test data set
testDataY <- read.table("UCI HAR Dataset/test/Y_test.txt")
# load the subjects from the test data set
testDataSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# load the training data set
trainDataX <- read.table("UCI HAR Dataset/train/X_train.txt")
# load the activities from the training data set
trainDataY <- read.table("UCI HAR Dataset/train/Y_train.txt")
# load the subjects from the train data set
trainDataSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")


## Appropriately label the data set with descriptive variable names
# load variable names (features.txt)
features <- read.table("UCI HAR Dataset//features.txt")

# load data.table library to change variable names
library(data.table)
# set variable names of the test data set to the names from feature.txt
setnames(testDataX, old = names(testDataX), new = as.character(features[, 2]))
# set the variable name of the activity column of the test data set to Activity
setnames(testDataY, old = names(testDataY), new = "Activity")
# set the variable name of the subject column of the test data set to Subject
setnames(testDataSubject, old = names(testDataSubject), new = "Subject")

# set variable names of the training data set to the names from feature.txt
setnames(trainDataX, old = names(trainDataX), new = as.character(features[, 2]))
# set the variable name of the activity column of the training data set to Activity
setnames(trainDataY, old = names(trainDataY), new = "Activity")
# set the variable name of the subject column of the training data set to Subject
setnames(trainDataSubject, old = names(trainDataSubject), new = "Subject")


## Merge the training and the test sets to create one data set
# bind the activity column (testDataY and trainDataY) to the rest of the data set (testDataX and trainDataX)
testData <- cbind(testDataY, testDataX)
trainData <- cbind(trainDataY, trainDataX)

# bind the subject column (testDataSubject and trainDataSubject) to the rest of the data set (testData and trainData)
testData <- cbind(testDataSubject, testData)
trainData <- cbind(trainDataSubject, trainData)

# remove the X and Y data from the memory
rm(testDataX, testDataY, testDataSubject, trainDataX, trainDataY, trainDataSubject)

# add variable dataset to both testData and trainData to specify weither the data is from the test or training dataset
testDataDataset <- data.frame(rep("test", nrow(testData)))
setnames(testDataDataset, old = names(testDataDataset), new = "Dataset")
testData <- cbind(testDataDataset, testData)

trainDataDataset <- data.frame(rep("train", nrow(trainData)))
setnames(trainDataDataset, old = names(trainDataDataset), new = "Dataset")
trainData <- cbind(trainDataDataset, trainData)

# merge the train and test data set into data
data <- rbind(trainData, testData)

# remove the train and test data sets from the memory
rm(testData, testDataDataset, trainData, trainDataDataset)


## Use descriptive activity names to name the activities in the data set
# load the labels of the activities (activity_labels.txt)
activityLabels <- read.table("UCI HAR Dataset//activity_labels.txt")

# change the activity indexes (1-6) to the activity names 
# (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
for (i in 1:6) {
    data$Activity[data$Activity == i] = as.character(activityLabels[i, 2])
}


## Extract only the measurements on the mean and standard deviation for each measurement
# find the variable names that include standard deviation (std) and mean (mean)
indexSubset <- as.logical(grepl("std", names(data)) + grepl("mean", names(data)))

# include the first two columns in the index (Subject and Activity)
indexSubset[1:3] <- TRUE

# subset the data using the index that includes all the variables with std, mean, Subject and Activity
dataSubset = data[, indexSubset]

# remove the original data set, the activity labels and the features list
rm(data, features)


## Create an independent tidy data set with the average of each variable for each activity and each subject
# create empty data frame (dataAverage) with number of rows from the multiplication of the total number of activities (6) and the number of subjects (30)
# the columns corresponds to Subject, Activity and all the variables from the subset data set
dataAverage <- data.frame(matrix(NA, nrow = dim(activityLabels)[1] * max(dataSubset$Subject), ncol = ncol(dataSubset)-1))

# set the names of the variables of the new data set to Subject, Activity and all the names of the variables
setnames(dataAverage, old = names(dataAverage), new = c("Subject", "Activity", names(dataSubset)[4:length(names(dataSubset))]))

# multiple for-loop to create the average data set
# set counter m to 1
m <- 1
# for-loop over all of subjects
for (i in 1:max(dataSubset$Subject)) {
    # for-loop over all of activities
    for (j in 1:dim(activityLabels)[1]) {
        # set the first column to the subject number
        dataAverage[m, 1] <- i
        # set the second column to the activity
        dataAverage[m, 2] <- as.character(activityLabels[j, 2])
        # for-loop over all the variables
        for (k in 1:(ncol(dataSubset)-3)) {
            # calculate the mean of each variable per subject and per activity
            dataAverage[m, k+2] <- mean(dataSubset[dataSubset$Activity==as.character(activityLabels[j, 2]) & dataSubset$Subject==i, k+3], na.rm = TRUE)
        }
        # increase the counter by 1 to create new rows
        m <- m+1
    }
}


## Write txt file with the average data set
write.table(x = dataAverage, file = "dataAverage.txt", sep = ",", row.name=FALSE)
