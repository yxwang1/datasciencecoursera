Data source

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Downloaded the data and unzipped in a local directory

DataFile

Read dataset files from UCI to given name and prefix. Know names are "train" and "test". Known prefixes are "X", "y" and "subject".

Examples:

train/X_train.txt
train/y_train.txt
train/subject_train.txt
features.txt
activity_labels.txt


Manipulating data

Load features names and clean up the names by substituting ',' with '-'
Assign the features names to testing data
Read activity labels for testing data
Name the column of the activity label to be "labelIndex"
Load subjects for testing
Assign the column name of the subject to be "subject"
merge test data, activityLabel and test subject into testDataset

Appropriately labels the data set with descriptive variable names.

1.Merges the training and the test sets to create one data set.

using rbind to merge testDataset with trainDataset

2. Extracts only the measurements on the mean and standard deviation for each measurement.
 retrieve all the columns with names containing 'Mean' or 'Std'
 select only the columns that have Mean or Std in the column names

3. Uses descriptive activity names to name the activities in the data set

Load the file containing mappings between index and activity labels

5. From the data set in step 4, creates a second, independent tidy data set 

with the average of each variable for each activity and each subject.

use summarize over groups by subject and then activity to obtain the mean for each subject and activity

Finally,
write the output file in cvs format

