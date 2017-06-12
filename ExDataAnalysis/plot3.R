# TODO: Add comment
# 
# Author: yachenq
###############################################################################
dataPath <- "/project/week1/household_power_consumption.txt"
pngPath <- "/project/week1/plot3.png"

data <- read.csv(dataPath, sep = ";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")
dateTime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(dateTime)


plot(x=data$Datetime,
		y= as.numeric(as.character(data$Sub_metering_1)),
		type="l",
		col="black",
		xlab="",
		ylab="Energy sub metering"
)
lines(x=data$Datetime,
		y= as.numeric(as.character(data$Sub_metering_2)),
		type="l",
		col="red")

lines(x=data$Datetime,
		y= as.numeric(as.character(data$Sub_metering_3)),
		type="l",
		col="blue")


legend("topright",lty=1, lwd=2, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c("black", "red", "blue"))
dev.copy(png, filename=pngPath, width=480, height=480)
dev.off()

#matplot(data$Datetime, data[7:9],  type = "l", col=c("black", "red", "blue"), ylab="Global Active Power (kilowatts)", xlab="")
