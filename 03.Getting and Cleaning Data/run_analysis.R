packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# Load activity labels and required features
v_activity <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt")
                        , col.names = c("index", "activity_name"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt")
                  , col.names = c("index", "feature_name"))
features_interested <- grep("(mean|std)\\(\\)", features[, feature_name])
measurements <- features[features_interested, feature_name]
measurements <- gsub('[()]', '', measurements)

# Get train data
train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, features_interested, with = FALSE]
data.table::setnames(train, colnames(train), measurements)
trainActivities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt")
                       , col.names = c("Activity"))
trainSubjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("SubjectNumber"))
train <- cbind(trainSubjects, trainActivities, train)

# Get test data
test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, features_interested, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActivities <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt")
                        , col.names = c("Activity"))
testSubjects <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt")
                      , col.names = c("SubjectNumber"))
test <- cbind(testSubjects, testActivities, test)

# merge data's
v_merge <- rbind(train, test)

v_merge[["Activity"]] <- factor(v_merge[, Activity]
                              , levels = v_activity[["index"]]
                              , labels = v_activity[["activity_name"]])

# Do calculation as per assignment
v_merge <- reshape2::melt(data = v_merge, id = c("SubjectNumber", "Activity"))
v_merge <- reshape2::dcast(data = v_merge, SubjectNumber + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = v_merge, file = "FinalTidyData.txt", quote = FALSE)