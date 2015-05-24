
library(dplyr)
library(reshape2)

loadData <- function (datasetFlag, datasetFolder, columnLabels, activityLabels){
  featureSetPath <- file.path(datasetFolder, datasetFlag, 
                              paste('X_', datasetFlag, '.txt',sep='') )
  activitySetPath <- file.path(datasetFolder, datasetFlag, 
                               paste('y_', datasetFlag, '.txt',sep='') )
  subjectSetPath <- file.path(datasetFolder, datasetFlag, 
                               paste('subject_', datasetFlag, '.txt',sep='') )
    
  message(paste('Loading: ', featureSetPath))
  
  # Load the feature set
  featureFrame <- read.table(featureSetPath, col.names = columnLabels)
  
  message(paste('Loading: ', activitySetPath))
  
  # Load the activity set
  activityFrame <- read.table(activitySetPath)
  activityFrame$ActivityName <- factor(activityFrame$V1, labels = activityLabels )
  
  message(paste('Loading: ', subjectSetPath))
  
  #Load the subject set
  subjectFrame <- read.table(subjectSetPath, col.names = 'SubjectNumber')
  
  # Rather than continue to work on the full dataset lets get only the columns
  # that we want to work on. Grep for those with mean() or std() in the name
  # See README.md for my choice behind columns
  meanColumns = grep(x = columnLabels, pattern = 'mean()', fixed = TRUE )
  stdColumns = grep(x = columnLabels, pattern = 'std()', fixed = TRUE )
  
  featureFrame <- featureFrame[,sort(c(meanColumns,stdColumns))]

  # Attach the subject and activity details to the frame
  featureFrame$ActivityName <- activityFrame$ActivityName
  featureFrame$SubjectNumber <- subjectFrame$SubjectNumber

  tbl_df(featureFrame)
}


main <- function () {
  message("Beginning data clean!")
  # Store the current working directory so we can switch back to it
  existingWD <- getwd()
  # Lets set the current working directory to where the script is located and
  # hopefully all the required files
  setwd(dirname(sys.frame(1)$ofile)) # http://stackoverflow.com/questions/1815606/rscript-determine-path-of-the-executing-script
  
  datasetFolder <- 'UCI HAR Dataset'
  
  # Confirm that the raw data is in our folder
  if(dir.exists(datasetFolder)){
    message("We have the raw data set")
    # Get the vector of column names
    columnNames <- read.table(file.path(datasetFolder,'features.txt'))$V2
    # Get the vector of activity names
    activityNames <- read.table(file.path(datasetFolder,'activity_labels.txt'))$V2
    
    # Load the test and training datasets
    testData <- loadData('test', datasetFolder, columnNames, activityNames)
    trainData <- loadData('train', datasetFolder, columnNames, activityNames)
    
    # Row bind the two together
    fullData <- rbind(trainData, testData)
    
    # Group by the ActivityName and the SubjectNumber and summarise each variable
    # by the mean
    activitySubjectGroup <- group_by(fullData, ActivityName, SubjectNumber)
    tidyData <- summarise_each(activitySubjectGroup, funs(mean))
    
    # Finally tidy up the variable names removing the '.' from the name and 
    # making them generally easier to read
    names(tidyData) <- gsub(".", "-", fixed = TRUE,
                            x = gsub("..", "", fixed = TRUE, 
                                     x = gsub("...", ".", fixed = TRUE, x=names(tidyData) ) 
                                     )
                            )
  } else {
    warning("We are missing the data set folder from the script location")
  }
  
  # Finally flip back to the users old working directory
  setwd(existingWD)
  
  # If we created the tidyData variable lets write the tidyData to the where 
  # the user had their working directory
  if(exists('tidyData')){
    write.table(tidyData,'tidyData.txt', row.names = FALSE )
  }
}

main()