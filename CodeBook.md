# Code Book
# Getting & Cleaning Data Project

The script `run_analysis.R` performs the 5 steps described in the course project instructions.

1) First, all similar data is merged using the r(bind) function.  First, we read in the subject ID for the training and test sets. Then we combine the train and test sets into a single data frame.  Next, we read in features data for training and testing and then combine it into a single data frame. This is followed by reading in a list of the features names and labels. 

2) Next, we extract only measurements on the mean and standard deviation for each measurement. This is followed by using the descriptive activity names to name the activities in the data set.  We read in the training and testing activities and then combine these into a single data frame.  

3)After recoding activity values as descriptive neams using the activity labels file we combine activities, subjects, and features into one data set. To clean the data, we then reorder the data so that the first column is 'Subject' and the second column is 'Activity'

4) For the final step, we get the averages of each variable and activity to generate a final data set.  This contains the measures for each subject and activity type (30 subjects * 6 activities = 180 rows).  The output file is called 'averages_dataset.txt' and uploaded to this github repository.


# Variables Used

* `subject_test`, `subject_train`, `features_test`, `features_train`, `feature_list` and `features_subset` contain the data from the downloaded files.

* `combined.subject`, `combined.features` and `combined.activities` merge the previous datasets to further analysis.

* 'activity_labels' is used with 'combined.activities' to recode the activity values as descriptive names using the activity labels file

* `all.data` contains the base data set which combines Actitivies, Subjects and Features all into one data frame with correct labels

* 'averages.data' contains the final data set. This final data set contains the measures for each subject and activity type (30 subjects * 6 activities = 180 rows).  The output file is called 'averages_dataset.txt' and uploaded to this github repository.
