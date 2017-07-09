# load 2 packages that will be used to this assignment:
# lubridate (Functions to work with date-times and time-spans); dplyr (Grammar of Data Manipulation)
# all are in the CRAN if you need to install
#  all the exercises will be done using base plotting system
# the data was downloaded from the course webpage and saved on my working directory for R
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

library(dplyr)
library(lubridate)

# read the data and create a table of it in R;
# set that NA values are called ? in this file;
data_full <-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

# the data file is big, so you can subset the useful part of it;
selected_data <-rbind(data_full[data_full$Date=="1/2/2007",],data_full[data_full$Date=="2/2/2007",])

# transform the date values;
selected_data$Date <- as.Date(selected_data$Date,"%d/%m/%Y")

# since you need date and time analysis versus power consuption, its a good idea to join the date and time in a new variable, to facilitate to graph it;
selected_data<-cbind(selected_data, "DateTime" = as.POSIXct(paste(selected_data$Date, selected_data$Time)))

# the next plotting is related to submetering 1 to 3;
# they shall have different collors, so you need to add one by one;
Plot_3 <- with(selected_data, {plot(Sub_metering_1 ~ DateTime, type="l", xlab= "", ylab="Energy Sub Metering")})
lines(selected_data$Sub_metering_2 ~ selected_data$DateTime, col = 'Red')
lines(selected_data$Sub_metering_3 ~ selected_data$DateTime, col = 'Blue')

# to print the graph as PNG
# if you would need to change resolution, you can find info in: https://danieljhocking.wordpress.com/2013/03/12/high-resolution-figures-in-r/
dev.copy(png, file = "Plot_3.png", height = 480, width = 480))
dev.off()
