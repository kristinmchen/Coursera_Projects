## Getting & Cleaning Data
## Kristin Chen
## Course Project
## 07.26.2015

run_analysis <- function() {
  
  ##install and run required packages
  install.packages("plyr", "data.table", "reshape2")
  library(plyr)
  library(data.table)
  library(reshape2)
 
  setwd("C:/Users/krchen/Documents/R/Coursera/gettingandcleaningdata/")
  ## Download & unzip files to your working directory
  
  #########################################################################
  ## PART 1: Merges the training and the test sets to create one data set.
  
  ## read in subject ID for training and test sets, add "Subject" column label
  subject_test <- read.table("C:/Users/krchen/Documents/R/Coursera/gettingandcleaningdata/UCI HAR Dataset/test/subject_test.txt", col.names = c("Subject"))
  subject_train <- read.table("C:/Users/krchen/Documents/R/Coursera/gettingandcleaningdata/UCI HAR Dataset/train/subject_train.txt", col.names = c("Subject"))
  
  ## combine train and test sets into single data frame
  combined.subject <- rbind(subject_test, subject_train)
  
  ## read in features DATA for training and testing "x_test" & "x_train" data
  features_test <-read.table("C:/Users/krchen/Documents/R/Coursera/gettingandcleaningdata/UCI HAR Dataset/test/X_test.txt")
  features_train <- read.table("C:/Users/krchen/Documents/R/Coursera/gettingandcleaningdata/UCI HAR Dataset/train/X_train.txt")
  
  ## combine features training and test data into a single data frame
  combined.features <- rbind(features_test, features_train)  
 
  ## read in LIST of features names & labels
  feature_list <- read.table("C:/Users/krchen/Documents/R/Coursera/gettingandcleaningdata/UCI HAR Dataset/features.txt")

  ## PART 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
  ## PART 3: Uses descriptive activity names to name the activities in the data set
  ## PART 4: Appropriately labels the data set with descriptive variable names. 
  
  ##select columns which have mean() and std() in their name
  features_subset <- grep("-(mean|std)\\(\\)", feature_list[, 2])
  
  ## subset mean & std columns
  combined.features <- combined.features[, features_subset]
  
  ## correct column names
  names(combined.features) <- feature_list[features_subset, 2]
  
  # Use descriptive activity names to name the activities in the data set
  
  ## read in training and testing activities 
  activities_test <-  read.table("C:/Users/krchen/Documents/R/Coursera/gettingandcleaningdata/UCI HAR Dataset/test/y_test.txt")
  activities_train <- read.table("C:/Users/krchen/Documents/R/Coursera/gettingandcleaningdata/UCI HAR Dataset/train/y_train.txt")
  
  #Combine training and test activities into single data frame and rename column to "activity" from "V1"
  combined.activities <- rbind(activities_test, activities_train)
  colnames(combined.activities) <- "Activity"
  
  ## Recode activity values as descriptive names using the activity labels file 
  activity_labels <- read.table("C:/Users/krchen/Documents/R/Coursera/gettingandcleaningdata/UCI HAR Dataset/activity_labels.txt")
  combined.activities[, 1] <- activity_labels[combined.activities[, 1], 2]
  
  ## Combine Actitivies, Subjects and Features all into one data frame
  all.data <- cbind(combined.features, combined.activities, combined.subject)
  
  ## reorder data Show subject then activity then other columns
  all.data <- all.data[,c(68,67, 1:66)]
    
  #####################################################################################
  ## PART 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  require(plyr)
  
  ## get averages of each variable & activity except the first two, Subject & Activity
  averages.data <- ddply(all.data, .(Subject, Activity), function(x) colMeans(x[, 3:68]))
  write.table(averages.data,file =  "averages_dataset.txt",row.name=FALSE)
}

