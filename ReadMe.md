---
title: "ReadMe"
author: "Tejus Maduskar"
date: "April 19, 2018"
output: html_document
---

## About this ReadMe
Explains how the script works.
 
There is only one script, called run_analysis.R
Sourcing the run_analysis.R script executes it, and performs all steps necessary to: 
(a) load dplyr package (utilized later in the script)
(b) download the group of zipped datasets from the URL provided
(c) unzip the datasets
(d) read the text and binay files into R datasets (dataframes)
(e) merge the dataframes appropriately
(f) label the variables appropriately
(g) reduce the merged dataframe into a narrow dataframe with 8 columns including Subject, Activity, and some of
the means and std. deviations
(h) replace numeric values (1-6) of Activity with their descriptive labels
(i) further modify variable names to appear more meaningful
(j) group rows by Subject and Activity, and average the values in the other six variables to create tidy data
(k) write the tidy dataset to a CSV file called "Assignment4TidyData.csv"