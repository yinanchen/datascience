# You should create one R script called run_analysis.R that does the following.
 
#
 
# 1. Merges the training and the test sets to create one data set.
 
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 
# 3. Uses descriptive activity names to name the activities in the data set
 
# 4. Appropriately labels the data set with descriptive variable names.
 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
 
if( !file.exists("UCI HAR Dataset") ) {
 
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "data.zip")
 
  unzip("data.zip")
 
}
 
 
data.features <- read.table("UCI HAR Dataset/features.txt", header = F, sep = " ")
 
data.activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = F, sep = " ")
 
 
## Load Train Data
 
data.train.x <- read.table("UCI HAR Dataset/train/X_train.txt")
 
data.train.y <- read.table("UCI HAR Dataset/train/y_train.txt")
 
data.train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
 
 
## Load Test Data
 
data.test.x <- read.table("UCI HAR Dataset/test/X_test.txt")
 
data.test.y <- read.table("UCI HAR Dataset/test/y_test.txt")
 
data.test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
 
 
## Combine Train and Test
 
data.x <- rbind(data.train.x, data.test.x)
 
data.y <- rbind(data.train.y, data.test.y)
 
data.subject <- rbind(data.train.subject, data.test.subject)
 
 
features.mean.std <- grepl("mean\\(\\)|std\\(\\)",data.features[,2])
 
 
data.extract.x <- data.x[,features.mean.std]
 
names(data.extract.x) <- data.features[features.mean.std,2]
 
 
 
names(data.y) <- "activityId"
 
names(data.activity.labels) <- c("activityId","activity")
 
 
data.y.named <- merge(data.y, data.activity.labels, by.x = "activityId", by.y = "activityId")[, 2]
 
 
data <- cbind(data.subject, data.y.named, data.extract.x)
 
names(data)[1] <- "subject"
 
names(data)[2] <- "activity"
 
 
write.table(data, "tidy_data.txt", row.names = F)
