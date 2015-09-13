## download and read file
#powerData <- fread(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE)
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

## plot 3
png(file="plot3.png", width = 480, height = 480)
with(newdf, {
  plot(datetime,Sub_metering_1,pch='.', ylab='Energy Sub Metering')
  lines(datetime,Sub_metering_1, col='black')
  lines(datetime,Sub_metering_2, col='red')
  lines(datetime,Sub_metering_3, col='blue')
  legend("topright",col=c('black', 'red', 'blue'), cex=0.5,
         legend = colnames(newdf)[8:10], lty=c(1,1,1))
})
dev.off()