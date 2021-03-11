
# Read features list
features <- read.table("UCI HAR Dataset/features.txt", sep = " ")[[2]]

# Get train data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
names(x_train) <- features
names(y_train) <- c("Activity")
y_train_labels <- factor(y_train$Activity,
    labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
             "SITTING", "STANDING", "LAYING"))

train <- cbind(x_train, y_train_labels)
names(train)[names(train) == "y_train_labels"] <- "Activity"

# Get test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
names(x_test) <- features
names(y_test) <- c("Activity")
y_test_labels <- factor(y_test$Activity,
    labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
             "SITTING", "STANDING", "LAYING"))

test <- cbind(x_test, y_test_labels)
names(test)[names(test) == "y_test_labels"] <- "Activity"

dataset <- rbind(train, test)


# Start scrubbing
library(dplyr)

mean_std <- select(dataset,
    c("Activity", features[grepl("mean\\(|std", names(dataset))]))

print(head(mean_std))
