# Original Data:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# -------------------------------------------------
# 1) Merging Training and Testing data sets into one set

train_S <- read.table("train/subject_train.txt")
train_X <- read.table("train/X_train.txt")
train_Y <- read.table("train/y_train.txt")

test_S <- read.table("test/subject_test.txt")
test_X <- read.table("test/X_test.txt")
test_Y <- read.table("test/y_test.txt")

all_S <- rbind(train_S, test_S)
all_X <- rbind(train_X, test_X)
all_Y <- rbind(train_Y, test_Y)

# -------------------------------------------------
# 2) Extract only the measurements on the mean and standard deviation for each measurement. 

# read features.txt and filter using grep to get appropriate locations of features in interest

features <- read.table("features.txt")
filteredFeatures <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

# filter X according to the features in interest and name columns appropriately
# remove brackets using gsub()
all_X <- all_X[, filteredFeatures]
names(all_X) <- features[filteredFeatures, 2]
names(all_X) <- gsub("\\(|\\)", "", names(all_X))

# -------------------------------------------------
# 3) Use descriptive activity names to name the activities in the data set

# use activity_labels.txt

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", as.character(activities[,2]))

# use activities to label Y set
all_Y[ ,1] <- activities[all_Y[,1], 2]
names(all_Y) <- "Activity"

# ---------------------------------------------------
# 4) Appropriately label the data set with descriptive activity names.

names(all_S) <- "Subject"
cleaned_data <- cbind(all_S, all_Y, all_X)
write_table(cleaned_data, "cleaned_merged_data.txt")

# ----------------------------------------------------
# 5) Creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject.

unique_subjects <- length(unique(all_S)[,1])
subject_list <- unique(all_S)[,1]
unique_activities <- length(activities[,1])


# the tidy data set should have as many rows as the combinations of activity and subject
tidy_data <- cleaned_data[1:(unique_subjects * unique_activities),]
i <- 1
for ( subject in 1:unique_subjects ) {
        for (activity in 1: unique_activities ) {
                tidy_data[i, 1] <- subject_list[subject]
                tidy_data[i, 2] <- activities[activity, 2]
                temp <- cleaned_data[ cleaned_data$Subject == subject & cleaned_data$Activity == activities[activity,2], ]
                tidy_data[i, 3:dim(cleaned_data)[2] ] <- colMeans(temp[, 3:dim(cleaned_data)[2]])
                i <- i + 1    
        }       
}

# save the tidy data table

write.table(tidy_data, "tidy_data.txt")
