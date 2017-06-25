# TODO: Add comment
# 
# Author: yachenq
###############################################################################
library(plyr)
library(ggplot2)

# Read data
scc_summary_data <- readRDS("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/NEI_data/summarySCC_PM25.rds")
scc_data <- readRDS("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/NEI_data/Source_Classification_Code.rds")
pngPath <- "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/plot4.png"

motor_scc <- scc_data[grepl('vehicle', scc_data$scc_data.Level.Two, ignore.case=T), ]
merge_data <- merge(x=scc_summary_data, y=motor_scc, by="SCC")
motor_bal_emi <- subset(merge_data, merge_data$fips=="24510")

aggMotor <- aggregate(Emissions ~ year, motor_bal_emi, sum)

ggplot(data = aggMotor, aes(x=year, y=Emissions)) + geom_line() + geom_text(aes(label=Emissions), vjust=-2)+ geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Emissions (thousands of tons)" ) + ggtitle("Baltimore Emissions from Motorcycle")
dev.copy(png, filename=pngPath)
dev.off ()
