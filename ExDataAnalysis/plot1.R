# TODO: Add comment
# Author: yachenq
###############################################################################
dataPath <- "/project/week1/household_power_consumption.txt"
pngPath <- "/project/week1/plot1.png"

data <- read.csv(dataPath, sep = ";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")
dateTime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(dateTime)

hist(as.numeric(as.character(data$Global_active_power)),  main="Global Active Power", col = "red", xlab = "Global active power (kilowatts)")
dev.copy(png, file=pngPath, height=480, width=480)
dev.off ()
