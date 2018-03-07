



## IMPORTANT!
## For the Checker to save time,
## please put household_power_consumption.txt in your working directory
## so there will be no need to download the 20 MB File.








## Downloads the source file if it is not in the current working directory, proceeds if it is 
destfiletxt = "./household_power_consumption.txt" 
destfilezip = "./exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(destfiletxt)){
  download.file(fileURL, destfile="./exdata%2Fdata%2Fhousehold_power_consumption.zip", method="auto")
  unzip("./exdata%2Fdata%2Fhousehold_power_consumption.zip")
}


## installs and loads required packages(if not yet installed)
if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}
if(!require(tidyr)){
  install.packages("tidyr")
  library(tidyr)
}
if(!require(png)){
  install.packages("png")
  library(png)
}
library(png)
library(dplyr)
library(tidyr)


## reads file, changes some variable classes for subsetting
hpc <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep=";", quote="\"", comment.char=""))
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power, stringsAsFactors = FALSE))
hpc$Date <- as.character(hpc$Date)
cdf1 <- subset(hpc, Date == "1/2/2007")
cdf2 <- subset(hpc, Date == "2/2/2007")
cdf <- rbind(cdf1,cdf2)
cdf$Sub_metering_1 <- as.numeric(as.character(cdf$Sub_metering_1, stringsasFactors =FALSE))
cdf$Sub_metering_2 <- as.numeric(as.character(cdf$Sub_metering_2, stringsasFactors =FALSE))
cdf$Sub_metering_3 <- as.numeric(as.character(cdf$Sub_metering_3, stringsasFactors =FALSE))



## create DateTime
cdf$DateTime <- paste(cdf$Date, cdf$Time)
cdf$DateTime <- strptime(cdf$DateTime, "%d/%m/%Y %H:%M:%S")



## creates the plot according to specifications
png("plot3.png", width=480, height=480)
plot3 <-  plot(cdf$DateTime,cdf$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(cdf$DateTime,cdf$Sub_metering_2,col="red")
lines(cdf$DateTime,cdf$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
dev.off()

## previews the plot3.png file in r and views the dataset used
dev.off()
img <- readPNG("./plot3.png")
grid::grid.raster(img)
View(cdf)