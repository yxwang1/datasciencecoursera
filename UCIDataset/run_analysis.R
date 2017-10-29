library(dplyr)

# Load features names and clean up the names by substituting ',' with '-'
features <- read.table("features.txt", na.strings="null", stringsAsFactors=FALSE)
features <- gsub(",", "-", features[,2])

test <- read.table("test/X_test.txt", na.strings="null", stringsAsFactors=FALSE)

# Assign the features names to testing data
names(test) <- features

# Read activity labels for testing data
testLabel <- read.table("test/y_test.txt", na.strings="null", stringsAsFactors=FALSE)

# Name the column of the activity label to be "labelIndex"
names(testLabel) <- c("labelIndex")

# Load subjects for testing
testSubject <-read.table("test/subject_test.txt", na.strings="null", stringsAsFactors=FALSE)
# Assign the column name of the subject to be "subject"
names(testSubject) <- c("subject")

# merge test data, activityLabel and test subject into testDataset
testDataset <- cbind(test, testLabel, testSubject)

train <- read.table("train/X_train.txt", na.strings="null", stringsAsFactors=FALSE)
# 4. Appropriately labels the data set with descriptive variable names.
names(train) <- features

trainLabel <- read.table("train/y_train.txt", na.strings="null", stringsAsFactors=FALSE)
# 4. Appropriately labels the data set with descriptive variable names.
names(trainLabel) <- c("labelIndex")

trainSubject <-read.table("train/subject_train.txt", na.strings="null", stringsAsFactors=FALSE)
# 4. Appropriately labels the data set with descriptive variable names.
names(trainSubject) <- c("subject")

trainDataset <- cbind(train, trainLabel, trainSubject)

# 1.Merges the training and the test sets to create one data set.

completeDataset <- rbind(testDataset, trainDataset)

completeDataset <- completeDataset[, !duplicated(colnames(completeDataset))]

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# retrieve all the columns with names containing 'Mean' or 'Std'
cols <- grep("[Mm]ean|[Ss]td", names(completeDataset), value=TRUE)
# select only the columns that have Mean or Std in the column names
meanNStdDataset <- select(completeDataset, cols)

# 3. Uses descriptive activity names to name the activities in the data set

# Load the file containing mappings between index and activity labels
activityLabels <- read.table("activity_labels.txt", na.strings="null", stringsAsFactors=FALSE)
names(activityLabels) <- c("labelIndex", "activityLabel")
activityLabelsDataset <- completeDataset
# Assign the activity labels corresponding to the activity index
activityLabelsDataset$activityLabel <- activityLabels[activityLabelsDataset$labelIndex,2]

# 4. Appropriately labels the data set with descriptive variable names.
# NOTE: See above

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# use summarize over groups by subject and then activity to obtain the mean for each subject and activity
tidyDataset <- activityLabelsDataset %>% group_by(subject, activityLabel) %>% summarise_if(is.numeric, funs(mean))

tidyDataset <- tbl_df(tidyDataset)

# write the output file in cvs format
write.csv(tidyDataset, "tidyDataset.txt", row.names=FALSE) 

