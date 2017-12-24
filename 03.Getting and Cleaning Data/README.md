# Getting and Cleaning Data Project
Author: Prakash Palaniappan <br />
Data Zip File Location: [UC Irvine Repo](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "Clicking will download the data")

## Analysis steps
1. Load the required packages used for this script such as "data.table", "reshape2".
2. Download and unzip the data file from the above Data URL. 
3. Load activity index and name from "activity_labels.txt"
4. Load all the available features from "features.txt"
5. Filter only required features as per assignment such as mean, std.
6. Combine training set "X_train.txt" with Y_train.txt(to get activity label) and subject_train.txt(to get the identifier of subject who carried out the experiment)
7. Repeat the step #6 for test data set as well.
8. Apppend training dataset with test dataset
9. Do create a independent tidy dataset with the average of each variable for each activity and each subject.
10. Write the created dataset in step #9 to a new text file.


