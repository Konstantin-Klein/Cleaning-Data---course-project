# ------------------------------------------------------------------

# Task for the course project: 

# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 

# read Readme.md and Codebook.md for more info

# ------------------------------------------------------------------

# install.packages(c("dplyr", "qdap"))

library(qdap)
library(dplyr)

# cleaning memory, setting file system parameters
rm(list = ls())
setwd("/Users/KK/Cloud@Mail.Ru/Learning/R/Cleaning\ data")  # set your working directory here
if(!file.exists("./raw"))  dir.create("./raw")
setwd("./raw")

# downloading and unzipping the data, checking for errors
# temporarily commented out assuming Samsung.zip is in the working directory 
#fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileUrl, "Samsung.zip", method = "curl")

unzip("Samsung.zip")

if(!file.exists("./UCI\ HAR\ Dataset/test/X_test.txt")) print("Error: no test dataset found")
if(!file.exists("./UCI\ HAR\ Dataset/train/X_train.txt")) print("Error: no train dataset found")
if(!file.exists("./UCI\ HAR\ Dataset/features.txt")) print("Error: file with variable names not found")
if(!file.exists("./UCI\ HAR\ Dataset/test/subject_test.txt")|
     !file.exists("./UCI\ HAR\ Dataset/train/subject_train.txt")) print("Error: file with subjects not found")
if(!file.exists("./UCI\ HAR\ Dataset/activity_labels.txt")) print("Error: file with activity labels not found")
if(!file.exists("./UCI\ HAR\ Dataset/test/y_test.txt")|
     !file.exists("./UCI\ HAR\ Dataset/train/y_train.txt")) print("Error: file with activities not found")

testTable <- read.table("./UCI\ HAR\ Dataset/test/X_test.txt")
trainTable <- read.table("./UCI\ HAR\ Dataset/train/X_train.txt")
namesTable <- read.table("./UCI\ HAR\ Dataset/features.txt")
testSubjects <- read.table("./UCI\ HAR\ Dataset/test/subject_test.txt")
trainSubjects <- read.table("./UCI\ HAR\ Dataset/train/subject_train.txt")
activityNames <- read.table("./UCI\ HAR\ Dataset/activity_labels.txt")
testActivities <- read.table("./UCI\ HAR\ Dataset/test/y_test.txt")
trainActivities <- read.table("./UCI\ HAR\ Dataset/train/y_train.txt")


# refining names for further processing in R, merging data, assigning refined names to variables

mergedTable <- rbind(testTable, trainTable)

refinedNamesTable <- make.names(namesTable[,2], unique = TRUE, allow_ = TRUE)
names(mergedTable) <- refinedNamesTable

# selecting only variables with mean or std in names, but not with meanFreq, etc.
filteredNamesTable <- refinedNamesTable[grep("mean\\.|std\\.",refinedNamesTable)]
filteredTable <- mergedTable[,grep("mean\\.|std\\.",refinedNamesTable)]

# adding subjects variable to the dataset
subjects <- rbind(testSubjects, trainSubjects)
names(subjects) <- "subject"
filteredTable$subject <- subjects[,1]

# adding activityName variable to the dataset
activities <- rbind(testActivities, trainActivities)
activityNamesVector <- lookup(activities,activityNames)
names(activityNamesVector) <- "activityName"
filteredTable$activityName <- activityNamesVector

# turning dataset into tbl_dt to enable group_by & summarise_each functions
filtered_tbl <- tbl_dt(filteredTable)
grouped_tbl <- group_by(filtered_tbl, activityName, subject)
summarised_tbl <- summarise_each(grouped_tbl, funs(mean))

write.table(summarised_tbl,"summary_tbl.txt", row.name=FALSE)
