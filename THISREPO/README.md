Getting and Clearing Data Course Project
========================================================

## Files included
* run_analysis.R
* codebook.md
* tidy_data.txt

## Steps to run the script:
* Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip it into the working directory. 
* Change working directory to "UCI HAR Dataset"
* Move run_analysis.R into the working directory
* Run script run_analysis.R
* The script will read the data and create the following in the working directory: 
        * cleaned_data.txt (10299x68 dataframe)
        * tidy_data (180x68 dataframe) with the average of each variable for activity and each subject (66 variables)
        
## Notes
* activity names are found in activity_labels.txt file
* different features are included in the features.txt file



