if (!file.exists("data")) {
dir.create ("data")
}


library(reshape2)

## Download and unzip the dataset:

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file (fileUrl, destfile="./data/dataweek4.zip")

unzip("./data/dataweek4.zip",exdir="./data")


# Load activity labels and feature

featurename <- read.table('./data/UCI HAR Dataset/features.txt',header=FALSE)
featurename[,2] <- as.character(featurename[,2])

activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
activityLabels[,2] <- as.character(activityLabels[,2])

# Extract only the data on mean and standard deviation

featuresRequired <- grep(".*mean.*|.*std.*", featurename[,2])
featuresRequired.names <- featurename[featuresRequired,2]
featuresRequired.names = gsub('-mean', 'Mean', featuresRequired.names)
featuresRequired.names = gsub('-std', 'Std', featuresRequired.names)
featuresRequired.names <- gsub('[-()]', '', featuresRequired.names)

# Load the test and training datasets


features_test<-read.table('./data/UCI HAR Dataset/test/X_test.txt',header=FALSE)[featuresRequired]

activity_test<-read.table('./data/UCI HAR Dataset/test/y_test.txt',header=FALSE)

subject_test<-read.table('./data/UCI HAR Dataset/test/subject_test.txt',header=FALSE)

test <-cbind(subject_test,activity_test,features_test)



features_train<-read.table('./data/UCI HAR Dataset/train/X_train.txt',header=FALSE)[featuresRequired]

activity_train<-read.table('./data/UCI HAR Dataset/train/y_train.txt',header=FALSE)

subject_train<-read.table('./data/UCI HAR Dataset/train/subject_train.txt',header=FALSE)

train<- cbind (subject_train,activity_train,features_train)


# merge training and test datasets to create one data set and add labels

completedataset<-rbind(train,test)
colnames(completedataset) <- c("subject", "activity", featuresRequired.names)


# convert activities and subjects into factors

completedataset$activity <- factor(completedataset$activity, levels = activityLabels[,1], labels = activityLabels[,2])

completedataset$subject <- as.factor(completedataset$subject)


# Calculate average of each variable for each activity and each subject and prepare secondary tidy dataset 

completedataset.melted <- melt(completedataset, id = c("subject", "activity"))

secondaryTidySet <- dcast(completedataset.melted, subject + activity ~ variable, mean)


# Write seconday tidy data set

write.table(secondaryTidySet, "secondarytidy.txt", row.names = FALSE, quote = FALSE)