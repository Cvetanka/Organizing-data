### Load general data, features list and activity labels list

Activity_Labels <- read.table("C:/Users/Cvetanka/Desktop/Cvetanka/Coursera/Data/UCI HAR Dataset/activity_labels.txt",header = F, col.names=c("Activity_ID","Activity Name"))
dim(Activity_Labels)
str(Activity_Labels)

Features <- read.table("C:/Users/Cvetanka/Desktop/Cvetanka/Coursera/Data/UCI HAR Dataset/features.txt")
dim(Features)  
str(Features)

### Find features mean and std out of all other features
extract_mean_std <- grepl("mean|std", (Features[,2]))

### Load test data
Test_SubjectTest <- read.table("C:/Users/Cvetanka/Desktop/Cvetanka/Coursera/Data/UCI HAR Dataset/test/subject_test.txt")
dim(Test_SubjectTest)
str(Test_SubjectTest)

Test_XTest <- read.table("C:/Users/Cvetanka/Desktop/Cvetanka/Coursera/Data/UCI HAR Dataset/test/X_test.txt")
dim(Test_XTest)
str(Test_XTest)

Test_yTest <- read.table("C:/Users/Cvetanka/Desktop/Cvetanka/Coursera/Data/UCI HAR Dataset/test/y_test.txt")
dim(Test_yTest)
str(Test_yTest)

### Assign the names to the test variables
names(Test_XTest) <- Features[,2]


### Extract mean and std from test measurements
Test_XTest <- Test_XTest[, extract_mean_std]

### Make one Test table

Test <- cbind(Test_SubjectTest, Test_yTest, Test_XTest)
dim(Test)


### Repeat the same procedure for train set; First load the train data 

Train_SubjectTrain <- read.table("C:/Users/Cvetanka/Desktop/Cvetanka/Coursera/Data/UCI HAR Dataset/train/subject_train.txt")
dim(Train_SubjectTrain)
str(Train_SubjectTrain)

Train_XTrain <-read.table("C:/Users/Cvetanka/Desktop/Cvetanka/Coursera/Data/UCI HAR Dataset/train/X_train.txt")
dim(Train_XTrain)
str(Train_XTrain)

Train_yTrain <- read.table("C:/Users/Cvetanka/Desktop/Cvetanka/Coursera/Data/UCI HAR Dataset/train/y_Train.txt")
dim(Train_yTrain)
str(Train_yTrain)

### Asign the names to the train variables
names(Train_XTrain) <- Features[,2]

### Extract the mean and std from train mesurements
Train_XTrain <- Train_XTrain[, extract_mean_std]

### Make one Train table
Train <- cbind(Train_SubjectTrain, Train_yTrain, Train_XTrain)
dim(Train)

###Now it's time to put together Test and Trein data 
Data <- rbind(Test, Train)
colnames(Data)[1][2] <- c("SubjectID","Activity")

### and calculate average of each variable by Subject and Activity
Mean_Data <- aggregate(Data, list(Data$SubjectID,Data$Activity),mean)
### Remove two aditional columns which appear by default when using aggregate function
Mean_Data$Group.1 <- NULL
Mean_Data$Group.2 <- NULL

### Give the proper name to every activity as given in Activity Labels
Mean_Data$Activity <- factor(Mean_Data$Activity, labels=Activity_Labels$Activity.Name)

### Finaly we can write our tidy data frame
Tidy <- write.table(Mean_Data, file="./Super_Tidy.txt", row.names=FALSE, sep = " ")


