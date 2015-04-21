# Code book

## Introduction
The provided R-script (run_analysis.R) is meant to independently read, re-order, analyse and save the Human Activity Recognition database. The database was built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The data set can be downloaded from: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/. This website also provides the following description of the dataset:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data (http://archive.ics.uci.edu/ml/machine-learning-databases/00240/). 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain (http://archive.ics.uci.edu/ml/machine-learning-databases/00240/).

## Variables
The data set contains the following variables (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones):
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration
- Triaxial Angular velocity from the gyroscope
- A 561-feature vector with time and frequency domain variables
- Its activity label
- An identifier of the subject who carried out the experiment

## Data
The data set is divided into a training and test data set. The R-script can be used to merge both data sets into a general data set. 

## Transformations
A selection is made of the data set that contains only the standard deviation and mean variables. From these variables, the average is calculated per subject and per activity. The new data set is stored in dataAverage.txt.