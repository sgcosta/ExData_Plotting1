#### Project: Project 1 Coursera 
#### Course: "Exploratory Data Analysis"
#### Date: October 10, 2014
#### Author: Costa, S.
#### Plot: Plot 3


## Set VariableS
# File URL to download
fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

# Local data file
dataFileZIP <- "./exdata-data-household_power_consumption.zip"

# Directory
dirFile <- "./Project"

# Directory and filename (txt) of the clean data
tidyDataFile <- "./household_power_consumption.txt"

# Download the dataset (.ZIP), which does not exist
if (file.exists(dataFileZIP) == FALSE) {
    download.file(fileURL, destfile = dataFileZIP)
}

# UnZIP data file
if (file.exists(dirFile) == FALSE) {
    unzip(dataFileZIP)
}

# Read and Clean Data
tidyDataTable <- read.table(tidyDataFile, 
                            header = TRUE, 
                            sep = ";",
                            colClasses = c("character", "character", rep("numeric",7)),
                            na = "?")

# Convert the Time variable to Time classe in R using the strptime() function.
tidyDataTable$Time <- strptime(paste(tidyDataTable$Date, tidyDataTable$Time), "%d/%m/%Y %H:%M:%S")

# Convert the Date variable to Date classe in R using the as.Date() function.
tidyDataTable$Date <- as.Date(tidyDataTable$Date, "%d/%m/%Y")

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")

# Create a subset using dates.
tidyDataTable <- subset(tidyDataTable, Date %in% dates)

## Plot3
## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels (units).
png("plot3.png", 
    width  = 480, 
    height = 480, 
    units  = 'px', 
    bg     = 'white')

## Set Margins :: mar (for margin) argument.
par(mar = c(7, 6, 5, 4))

plot(tidyDataTable$Time, 
     tidyDataTable$Sub_metering_1, 
     col="black",
     xlab = "",
     xaxt = NULL,
     ylab = "Energy sub metering",
     type = "n")

## Sub_metering_1 line
lines(tidyDataTable$Time, 
      tidyDataTable$Sub_metering_1, 
      col  = "black", 
      type = "S")

## Sub_metering_2 line
lines(tidyDataTable$Time, 
      tidyDataTable$Sub_metering_2, 
      col  = "red", 
      type = "S")

## Sub_metering_3 line
lines(tidyDataTable$Time, 
      tidyDataTable$Sub_metering_3, 
      col  = "blue", 
      type = "S")

## Legend
legend("topright",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1)

dev.off()
