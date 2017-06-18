# You should create one R script called run_analysis.R that does the following.

#

# 1. Merges the training and the test sets to create one data set.

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# 3. Uses descriptive activity names to name the activities in the data set

# 4. Appropriately labels the data set with descriptive variable names.

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##---packages required---
## install.packages("magrittr")

library(magrittr)
library(dplyr)

## Load train/test data

subTrainFilePath <- "/UCI HAR Dataset/train/subject_train.txt"
subTestFilePath <- "/UCI HAR Dataset/test/subject_test.txt"

subTrainData <- read.table(subTrainFilePath, col.names="subject")
subTestData <- read.table(subTestFilePath, col.names="subject")

xTrainFilePath <- "/UCI HAR Dataset/train/X_train.txt"
xTestFilePath <- "/UCI HAR Dataset/test/X_test.txt"

xTrainData <- read.table(xTrainFilePath)
xTestData <- read.table(xTestFilePath)

yTrainFilePath <- "/UCI HAR Dataset/train/Y_train.txt"
yTestFilePath <- "/UCI HAR Dataset/test/Y_test.txt"

yTrainData <- read.table(yTrainFilePath, col.names="activity")
yTestData <- read.table(yTestFilePath, col.names="activity")

## Merge train/test data
yAllData <- rbind(yTrainData, yTestData)
subAllData <- rbind(subTrainData, subTestData)
allData <-  rbind(xTrainData, xTestData)

## Read feature
featureFilePath <- "/UCI HAR Dataset/features.txt"
featureData <- read.table(featureFilePath, col.names=c("featureNum","featureName"))

## Merge columns
names(allData) <- featureData$featureName
allData <- cbind(allData, subAllData, yAllData)

## Filter by feature name
subsetFeatureData <- featureData[grepl("mean\\(\\)|std\\(\\)", featureData[,2]),]
subsetData <- allData[ ,which(names(allData) %in% c("subject","activity", as.character(subsetFeatureData$featureName)))]

## Read activity label
activityFilePath <- "/UCI HAR Dataset/activity_labels.txt"
activityLabels <- read.table(activityFilePath, col.names=c("activityNum","activityName"))
subsetData <- merge(subsetData, activityLabels, by.x = "activity", by.y = "activityNum")

## a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- subsetData %>%  group_by(subject, activity) %>% summarise_each(funs(mean))

tidyDataPath <- "/UCI HAR Dataset/tidy_data.txt"
write.table(tidyData, tidyDataPath, row.names = F)
