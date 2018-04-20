---
title: "Code Book"
author: "Tejus Maduskar"
date: "April 19, 2018"
output: html_document
---

## About this Code Book
Describe the variables, the data, and transformations performed to clean up the data as per assignment 4
--------------------------------------------------------------------------------------------------------
First, the following downloaded text files are read into R data sets (as dataframes): 
subtect_test, x_test, y_test, subject_train, x_train, y_train, activity_labels, and features

Next, the dimensions and contents of each dataframe are observed (using R commands or Notepad/Notepad++ app),
and block diagrams drawn, to help determine how to merge them. One logical aproach is to:
1. rbind xTest over xTrain, and name the columns of the merged dataframe using the values in features
2. rbind sTest over sTrain to capture all 30 subjects, and name the column 'Subject'
3. rbind yTest over yTrain, and name the column 'Activity'. 
4. Replace values 1-6 in Activity column with descriptive labels in Activity Labels (WALKING, LAYING, etc.)
5. Do additional merging to attain following variable order (L-R): Subject, Activity, Features (measures)

Narrow the dataframe from 563 to just 8 variables, where variables 3-8 are mean and std. deviation values:
Subject, Acvitiy, tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, tBodyAcc-std()-X, tBodyAcc-std()-Y, tBodyAcc-std()-Z

Further modify the variable names by replacing "t" with "time", and "-" with "."

Group the dataframe by Subject and Activity, and apply mean function to the mean and std. dev. variables, to produce a tidy dataset. Write the dataset into a CSV file caled "Assignment4TidyData.csv"

This CSV dataset has 8 variables, as follows:
Subject, Acvitiy, timeBodyAcc.mean()-X, timeBodyAcc.mean()-Y, timeBodyAcc.mean()-Z, timeBodyAcc.std()-X, timeBodyAcc.std()-Y, timeBodyAcc.std()-Z

There are 180 rows of data (observations), grouped by Subject (there are 30 subjects) and by Activity (each
subject has 6 activities). 