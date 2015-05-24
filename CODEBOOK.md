# Getting and Cleaning Data (Programming Assignment)

## Codebook

The variables in this dataset represent the average by activity and subject of the raw data in the training and test sets. 

ActivityName is the activity that was taking place and SubjectNumber is the integer used to identify each subject.

The other variables are all prefixed with 'Mean-' to represent that these are the mean of the measurements. They are then split into two groups, the time domain signals which are prefixed with a 't' (after 'Mean-') and the Fast Fourier Transform of the same signals which are prefixed with an 'f'. The units for the acceleration measures (those with "Acc" in the name) are in standard gravity units 'g' and the gyroscope measures (those with "Gyro" in the name) are in 'radians/second'.

The 'mean' and 'std' in the variable names represent the average and standard deviation of the underlying measurements

X, Y and Z are the spatial direction of those measurements where this is relevant (any variables derived from the gyroscope)

For an indepth explaination of what exactly each variable means see [features_info.txt](UCI HAR Dataset/features_info.txt)

## Study Design

The data was collected by having 30 volunteers perform certain activites while wearing a Samsung Galaxy S2 on their waist. The measurements are taken form the embedded accelerometer and gyroscope. Further information is available in ['README.txt'](UCI HAR Dataset/README.txt)

As requested the tidy dataset is all the mean and standard deviation measurements from the raw data averaged by each activity and subject. 
