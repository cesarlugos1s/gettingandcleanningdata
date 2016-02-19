# Getting and Cleanning Data

Author: Cesar Lugo.
Version: 1.0 .
Version release date: February 19, 2016  .
Subject: Getting and Cleanning data, Data Science specialization, assignment.

This document sumarizes the different documents this work created to analyze some statistical data that comes from a study 
that gathered information of some persons performing some activities while using some wearable
devices, which recorded some relevant information regarding those activities.

The final result is to obtain a dataset (named selecteddataaverages here) that contains averages of
some selected data grouped by activity performed and by the subject who performed the activity.


## Source raw data

The source data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here you can find the source data used in this project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Codebook

The codebood included in this repository is named CODEBOOK.md. In this document you will find:
- A Study Design section, describing the raw data souce used in this work, including the files and information that where used.
- A Codebook section, describing the variables generated from this work, an explanation of it´s contents, the summarization level, and the corresponding units.
- Script process details sections. This section describes all major steps followed to read, select and summarize the data, up to the point where the result is created.

## The instructions list, in R

This instructions list is contained in the run_analysis.R file. 
This file contains an R script with the instructions list on 
how the data gets read, selected and summarized, up to the point where the result is created.

In order to execute the R script, go to R, locate the directory where you downloaded the source zip file, 
where the "test" and "train" directories exists, and execute this command:
- run_analysis()
You can find these directions and further details in the Codebook, within the Script process details section.