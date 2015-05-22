
loadData <- function (datasetFlag, datasetFolder, columnLabels, activityLabels){
  featureSetPath <- file.path(datasetFolder, datasetFlag, 
                              paste('X_', datasetFlag, '.txt',sep='') )
  activitySetPath <- file.path(datasetFolder, datasetFlag, 
                               paste('y_', datasetFlag, '.txt',sep='') )
  message(paste('Loading: ', featureSetPath))
  dataFrame <- read.table(activitySetPath)
  #names(dataFrame) <- columnLabels
  print(names(dataFrame))
  
  
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
    
    testData <- loadData('test', datasetFolder, columnNames, activityNames)
    
  } else {
    warning("We are missing the data set folder from the script location")
  }
  
  # Finally flip back to the old working directory
  setwd(existingWD)
}

main()