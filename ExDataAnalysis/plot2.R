Sys.setlocale(category = "LC_ALL", locale = "english")
dataPath <- "/project/week1/household_power_consumption.txt"
pngPath <- "/project/week1/plot2.png"

data <- read.csv(dataPath, sep = ";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")
dateTime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(dateTime)

plot(data$Datetime, as.numeric(as.character(data$Global_active_power)), 
		ylab="Global Active Power (kilowatts)", xlab="", type = "l")

dev.copy(png, filename=pngPath, width=480, height=480)
dev.off ()
