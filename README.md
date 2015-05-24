# Getting and Cleaning Data (Programming Assignment)

This repository holds the programming assignment for Getting and Cleaning data, a part of the Data Science specialization on Coursera

The purpose of this assignment was to take the [raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) on human activity measured by a smartphones gyroscope and accelerometer and create a tidy data set from it.

This would involve...

* Merging the test and training data sets
* Assigning the feature names to the data 
* Selecting those features that were a mean or standatd deviation 
* Adding and translating the activity values to a readable value 
* Adding the subject numbers
* Summarising the data by activity and subject number
* Writing the tidy data out to a file

## Contents

* [CODEBOOK.md](CODEBOOK.md) - Information about the variables in the tidy data (explanation and units) and how the data was collected and summarised
* [INSTRUCTIONS.md](Instructions.md) - Instructions on how to execute the run_analysis.R file
* [run_analysis.R](run_analysis.R) - The script that creates the tidy data from the raw data
* [UCI HAR Dataset](UCI HAR Dataset) - The raw data on Human Activity Recognition sourced from [Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* [tidyData.txt](tidyData.txt) - The tidy data; an average of the mean and standard deviation variables from the raw data grouped by activity and subject number

## Feature selection

**Extracts only the measurements on the mean and standard deviation for each measurement**

As part of my `loadData` function I chose to select only the columns with either 'mean()' or 'std()' in their name.

```r
meanColumns = grep(x = columnLabels, pattern = 'mean()', fixed = TRUE )
stdColumns = grep(x = columnLabels, pattern = 'std()', fixed = TRUE )
```

I made the choice to ignore 'meanFreq()' as this was a weighted avereage of the frequency components rather than a 'vanilla' mean and has no corresponding standard deviation which I would argue should typically come with a mean (in order to give us an idea of how the data is distributed)

Finally I ignored the angle() features because while many of them use a mean as part of their computation (Eg. `angle(tBodyAccMean,gravity)`) the output is actually the angle between the two vectors

## Conforming to Tidy Data Principals

### Each variable should be in one column

Each column in the tidy data represents only one feature

I kept those features with an X, Y and Z measure separate because while they are likely correlated they are separate spatial dimensions and it's not unrealistic to have a measure in one but not the other two

### Each different observation of that variable in a different row

Each row in the tidy data is the mean of all the observations by activity and subject number and each row is a unique combination of activity and subject.

### There should be only one table for each kind of variable

All the data for this has been submitted in one table and this is because **ALL** the tidy data represents the `mean()` of all the underlying raw data.  

There are a few other reasons that it would be impractical to submit this in separate files

* How we were requested submit the data

*Please upload your data set as a txt file created with write.table*

So we have to submit one text file created with `write.table()` which doesn't really work with creating separate tables easily (It's probably possible but not without additional hacks around `read.table()`). 





