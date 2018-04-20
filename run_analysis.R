## Week 4 assignment/project of 'Getting and Cleaning Data' course
## HAR data (human activity recognition) from wearables. Details saved in C/../Assignments folder  
## 
## Pre-assignment work - download and unzip files from the following URL:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## 
## Load 'dplyr' package for use in task 5
library(dplyr)

## Download and unzip data files:
setwd("C:/Users/Tejus Madusker/Desktop/R-Coursera/data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("HAR.zip")){
    download.file(fileUrl, destfile = "HAR.zip", mode = "wb")
}
unzip("HAR.zip")

## Assignment Task 1. Merge the training and the test sets to create one data set
## ------------------------------------------------------------------------------
## First, read in the downloaded text files in test, train and UCI HAR Dataset folders: 
## subtect_test, x_test, y_test, subject_train, x_train, y_train, activity_labels, and features 

setwd("C:/Users/Tejus Madusker/Desktop/R-Coursera/data/HAR/UCI HAR Dataset/test")
sTest <- read.table("subject_test.txt")
xTest <- read.table("X_test.txt")
yTest <- read.table("y_test.txt")
setwd("C:/Users/Tejus Madusker/Desktop/R-Coursera/data/HAR/UCI HAR Dataset/train")
sTrain <- read.table("subject_train.txt")
xTrain <- read.table("X_train.txt")
yTrain <- read.table("y_train.txt")
setwd("C:/Users/Tejus Madusker/Desktop/R-Coursera/data/HAR/UCI HAR Dataset")
actLabel <- read.table("activity_labels.txt")
features <- read.table("features.txt")

## Next, get dimensions of each dataframe using dim() or by observing the Data window of RStudio. 
## Examine the contents using head(), tail(), or View() on the dataframes, or by opening source text files
## in Notepad, Notepad++ or UltraEdit and identify variables names and values. To help determine which 
## dataframes to merge and how, draw block diagram of each on paper roughly scaled to size (no. of rows and 
## cols), and withe content type inside the blocks.
##
## It appears that the most logical way to merge all 8 dataframes is as follows:
## ----------------------------------------------------------------------------
## 1. Place xTest above xTrain and name the columns of the merged dataframe using the values in features
## 2. Place sTest above sTrain as they jointly identify the 30 subjects. Name the column 'Subject'
## 3. Place yTest above yTrain, name column 'Activity', replace values 1-6 with labels (from actLabel)
## 4. Do additional merging to attain the column order (L-R): subjects, activities, features (measures)

## 1.
xTestTrain <- rbind(xTest, xTrain)
featuresVector <- features[, 2]
names(xTestTrain) <- featuresVector

## 2.
sTestTrain <- rbind(sTest, sTrain)
names(sTestTrain) <- "Subject"

## 3.
yTestTrain <- rbind(yTest, yTrain)
names(yTestTrain) <- "Activity"

## 4.
subjectActivityFeatures <- cbind(sTestTrain, yTestTrain, xTestTrain)

## Assignment Task 2: Extract only the measurements on mean and standard deviation for each measurement
## ----------------------------------------------------------------------------------------------------
## Question is, which mean and std dev measures? There are mean() and std() variables at positions 1-6, at
## 41-46, 81-86, 121-126, 161-166, 201-202, 214-215, 227-228, 240-241, 253-254, 266-271, 294-296, 345-350,
## 424-429, 503-504, 516-517, 529-530, and 542-543 in features file (PS: 555-561 are not mean and std)
## All of them? Per course forum advice, you can either extract variables with mean and std in their names,
## or those with mean() and std() in their names. Their is no right or wrong answer - this is your choice! 
##
## Too keep it simple let's only extract columns 1-8 of subjectActivityFeatures, where 3-8 are mean and std:
## tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, 
## tBodyAcc-std()-X, tBodyAcc-std()-Y, tBodyAcc-std()-Z

safMeanStd <- subjectActivityFeatures[, 1:8]

## Assignment Task 3: Use descriptive activity names to name the activities in the data set
## ----------------------------------------------------------------------------------------
## This means replace the numeric values 1-6 in column 2 ("Activity") of safMeanStd with their descriptive
## counterparts WALKING, WALKING_UPSTAIRS, etc., from the actLabel dataframe
## Let's make a copy of safMeanStd that we can manipulate, in case we need the original safMeanStd again
## Convert the numeric Activity column into character column so that we can then assign descriptive values
SAF <- safMeanStd
SAF$Activity <- as.character(SAF$Activity)
SAF$Activity[SAF$Activity == "1"] <- "WALKING"
SAF$Activity[SAF$Activity == "2"] <- "WALKING_UPSTAIRS"
SAF$Activity[SAF$Activity == "3"] <- "WALKING_DOWNSTAIRS"
SAF$Activity[SAF$Activity == "4"] <- "SITTING"
SAF$Activity[SAF$Activity == "5"] <- "STANDING"
SAF$Activity[SAF$Activity == "6"] <- "LAYING"

## Assignment Task 4: Appropriately label the data set with descriptive variable names
## ------------------------------------------------------------------------------------
## Let's replace the "t" in variable names with "time", and replace "-" (dash) with "." (dot)
colnames(SAF) <- sub("tBody", "timeBody", colnames(SAF))
colnames(SAF) <- sub("-", ".", colnames(SAF))

## Assigment Task 5: From the data set in step 4, create a second, independent tidy data set with average 
## of each variable for each activity and each subject.
## ------------------------------------------------------------------------------------------------------ 
## This is where the dplyr package, loaded at the top of the script, comes handy. Use group_by and summarize
## functions of dplyr as follows. But use a copy of SAF (to preserve SAF in case needed again later)
SAF1 <- SAF
SAF1 <- group_by(SAF1, Subject, Activity)
SAF1 <- summarise_all(SAF1, mean)
View(SAF1)

## Write tidy data as a csv
write.csv(SAF2, file = "Assignment4TidyData.csv")
## This results in only 180 rows - one for each combination of Subject and Activity, as desired

## End of script ##
##
## References and Credits: (suggested in course assignment forum by mentors)
## (1) Course project help guide:
## https://drive.google.com/file/d/0B1r70tGT37UxYzhNQWdXS19CN1U/view
##
## (2) thoughtfulbloke aka David Hood blog: 
## https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
##
## (3) Downloading zipped files tutorial on GitHub: 
## https://github.com/lgreski/datasciencectacontent/blob/master/markdown/rprog-downloadingFiles.md