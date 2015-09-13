## read file
#powerData <- fread("household_power_consumption.txt", sep=";", header=TRUE)
temp <- "household_power_consumption.zip"
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = temp, method = "curl")
powerData <- read.table(unz(temp, "household_power_consumption.txt"),sep=";", header=TRUE,
                        colClasses=rep("character",9))
unlink(temp)

## subset file to particular days
powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")
powerData2<- powerData[powerData$Date==as.Date('2007-02-01', format="%Y-%m-%d") 
                     | powerData$Date==as.Date('2007-02-02', format="%Y-%m-%d"),]

## construct new data frame as numeric
newDate <- paste(powerData2$Date, powerData2$Time)
datetime <- strptime(newDate, "%Y-%m-%d %H:%M:%S")
measurements<- sapply(powerData2,as.numeric)
newdf <- data.frame(datetime,measurements)

## plot 2
png(file="plot2.png", width = 480, height = 480)
with(newdf, {
  plot(datetime,Global_active_power, xlab="datetime", 
       ylab="Global Active Power (kilowatts)", pch='.')
  lines(datetime,Global_active_power)
})
dev.off()
