library(dplyr)

# 4. Appropriately labels the data set with descriptive variable names.
features <- read.table("features.txt", na.strings="null", stringsAsFactors=FALSE)
features <- gsub(",", "-", features[,2])
features <- make.names(features, unique=TRUE)

test <- read.table("test/X_test.txt", na.strings="null", stringsAsFactors=FALSE)

# 4. Appropriately labels the data set with descriptive variable names.
names(test) <- features

testLabel <- read.table("test/y_test.txt", na.strings="null", stringsAsFactors=FALSE)

# 4. Appropriately labels the data set with descriptive variable names.
names(testLabel) <- c("labelIndex")

testSubject <-read.table("test/subject_test.txt", na.strings="null", stringsAsFactors=FALSE)
# 4. Appropriately labels the data set with descriptive variable names.
names(testSubject) <- c("subject")

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

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

cols <- grep("[Mm]ean|[Ss]td", names(completeDataset), value=TRUE)

meanNStdDataset <- select(completeDataset, cols)

# 3. Uses descriptive activity names to name the activities in the data set

activityLabels <- read.table("activity_labels.txt", na.strings="null", stringsAsFactors=FALSE)
names(activityLabels) <- c("labelIndex", "activityLabel")
activityLabelsDataset <- completeDataset
activityLabelsDataset$activityLabel <- activityLabels[activityLabelsDataset$labelIndex,2]

# 4. Appropriately labels the data set with descriptive variable names.
# NOTE: See above

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

tidyDataset <- activityLabelsDataset %>% group_by(subject, activityLabel) %>% summarise_if(is.numeric, funs(mean))

tidyDataset <- tbl_df(tidyDataset)

write.table(tidyDataset, "tidyDataset.txt", row.names=FALSE) 
