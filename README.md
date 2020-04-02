# Getting-and-Cleaning-Data-Course-Project
Course Assignment for Coursera Getting and Cleaning Data Course

I read in the data files using the read.table function. 

I utilized the cbind function to merge the test and training data together.

I then left joined the merged data set to the activity file to assign the appropriate activity per record

I removed duplicated columns as I was trying to use the "contains" feature in the select function in the dply function. Before removing the duplicated columns, I made sure that the duplicated columns did were not mean/std calculations.

Once that cleared, I selected the calculations that had mean() or std() in the name.

For the last question, I used the group_by and summarise_each to find the mean of each respective column
