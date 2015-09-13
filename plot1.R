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
## plot 1
png(file="plot1.png", width = 480, height = 480)
hist(as.numeric(powerData2$Global_active_power), 
     col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()