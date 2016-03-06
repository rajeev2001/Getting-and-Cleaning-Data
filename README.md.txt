# Getting and Cleaning Data - Course Project

## This is the course project for the Getting and Cleaning Data Coursera course. run_analysis.R script does the following:

Download and unzip the dataset if it does not already exist in the working directory
Load the activity and feature info
Loads training and test datasets extracting only those columns which reflect a mean or standard deviation
Loads the activity and subject data for each dataset, and merges those columns with the dataset
merge training and test datasets to create one data set and add labels
Converts the activity and subject columns into factors
Calculate average of each variable for each activity and each subject and prepare secondary tidy dataset 
Output of tidy data set is shown in the file secondarytidy.txt.

### CodeBook.md describes variables,the data,and any transformations or work that was performed to clean up the data.