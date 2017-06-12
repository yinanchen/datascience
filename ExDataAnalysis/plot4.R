# TODO: Add comment
# 
# Author: yachenq
###############################################################################
dataPath <- "/project/week1/household_power_consumption.txt"
pngPath <- "/project/week1/plot4.png"

data <- read.csv(dataPath, sep = ";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")
Datetime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(Datetime)

par(mfrow = c(2,2))

plot(x = data$Datetime,
		y = as.numeric(as.character(data$Global_active_power)),
		type = "l",
		col = "black",
		xlab = "",
		ylab = "Global Active Power"
)

plot(x = data$Datetime,
		y = as.numeric(as.character(data$Voltage)),
		type = "l", 
		col = "black", 
		xlab = "datetime", 
		ylab = "Voltage"
)

plot(x = data$Datetime,
		y = as.numeric(as.character(data$Sub_metering_1)),
		type = "l",
		col = "black",
		xlab = "" ,
		ylab = "Energy sub metering"
)

lines(x = data$Datetime,
		y = as.numeric(as.character(data$Sub_metering_2)),
		type = "l",
		col = "red")

lines(x = data$Datetime,
		y = as.numeric(as.character(data$Sub_metering_3)),
		type = "l",
		col = "blue")

legend("topright" ,
		legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
		lwd = 1, 
		bty = "n",
		col = c("black", "red", "blue"))

plot(x = data$Datetime,
		y = as.numeric(as.character(data$Global_reactive_power)),
		type = "l", 
		col = "black",
		xlab = "datetime", 
		ylab = "Global_reactive_power"
)


dev.copy(png, file=pngPath, height=480, width=480)
dev.off()

