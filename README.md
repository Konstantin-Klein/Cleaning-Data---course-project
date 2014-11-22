Cleaning-Data---course-project
==============================

Course project for "Getting and Cleaning Data Coursera course  
Konstantin Klein
Konstantin.a.klein@gmail.com

The project is based on: 
==============================

Human Activity Recognition Using Smartphones Dataset
Version 1.0
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The source data:
==============================

The source data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the sourse data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


This repository contains:
==============================

- run_analisis.R R-language script that processes the source data and writes resulting datatable into summary_tbl.txt file in the wokring directory.
- summary.txt file with the resulting dataset 
- codebook.md file describing all the variables of the summary_tbl.txt file. 
- this readme.md file. 


How the data was processed:
==============================

- data was downloaded and unzipped
- data integrity was verified, if any file is missing an error is reported
- two dataframes (test.txt and train.txt) were merged with rbind
- names from features.txt were refined with make.names function and assigned to the variables 
- only variables containing standard deviations and means were selected usinf grep command
- subject column was added to the dataframe
- activityName vector was created by qdap::lookup function and added to the dataframe
- the resulting dataframe was then courced into tbl_dt
- summarised_tbl of tbl_dt class was created by applying group_by and summarise_each functions to the data_tbl
- summarised_tbl contains averages (means) of each datapoint grouped by activityName and subject columns


Notes: 
======
- Columns of summarised_tbl correspond to selected variables of source data.
- Each row contains means for all variables for every (activityName, subject) pair.

