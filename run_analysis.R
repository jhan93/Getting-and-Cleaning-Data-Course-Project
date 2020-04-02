setwd('UCI HAR Dataset')

## Universal ##
var_name <- read.table('/Users/jhan/Desktop/Coursera/UCI HAR Dataset/features.txt')
activity_label <- read.table('/Users/jhan/Desktop/Coursera/UCI HAR Dataset/activity_labels.txt', stringsAsFactors = FALSE)
names(activity_label) = c('label', 'activity')

## Train Set ##
set_train <- read.table('/Users/jhan/Desktop/Coursera/UCI HAR Dataset/train/X_train.txt')
label_train <- read.table('/Users/jhan/Desktop/Coursera/UCI HAR Dataset/train/y_train.txt')
subj_train <- read.table('/Users/jhan/Desktop/Coursera/UCI HAR Dataset/train/subject_train.txt')
names(set_train) = var_name$V2
names(subj_train) = 'subject'
names(label_train) = 'label'

train <- cbind(subj_train, label_train, set_train)

## Test Set ##
set_test <- read.table('/Users/jhan/Desktop/Coursera/UCI HAR Dataset/test/X_test.txt')
label_test <- read.table('/Users/jhan/Desktop/Coursera/UCI HAR Dataset/test/y_test.txt')
subj_test <- read.table('/Users/jhan/Desktop/Coursera/UCI HAR Dataset/test/subject_test.txt')
names(set_test) = var_name$V2
names(subj_test) = 'subject'
names(label_test) = 'label'

test <- cbind(subj_test, label_test, set_test)

## 1. Merges the training and the test sets to create one data set ##
combine <- as.data.frame(rbind(train,test))
combine <- merge(x = combine, y = activity_label, by = "label", all.x = TRUE)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement ##
library(dplyr)

##Remove duplicated column names - didn't matter since the mean and std column names were not affected.
combine <- combine[ , !duplicated(colnames(combine))]
mean_std <- (combine %>% select(subject, activity, contains('mean()'), contains('std()')))

## 3. Uses Descriptive Activity names to name the activities in the data set
## Already joined the activity information at the top after merging the test and training
## See line 30

## 4. Used the variable names that were already provided from the features.txt file

## 5. Summarise_each
## From the data set in step 4 (mean_std) create a second independent tidy data set with the average
## of each variable for each activity and each subject
final <- mean_std %>% group_by(subject, activity) %>% summarise_each(funs(mean))
