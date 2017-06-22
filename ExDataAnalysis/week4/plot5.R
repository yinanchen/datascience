# TODO: Add comment
# 
# Author: yachenq
###############################################################################
library(plyr)
library(ggplot2)

# Read data
EMI <- readRDS("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/NEI_data/Source_Classification_Code.rds")
pngPath <- "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/plot5.png"

#subset_data <- EMI[,c('SCC','year','fips','Emissions')]
motorSCC <- SCC[grepl('vehicle', SCC$SCC.Level.Two, ignore.case=T), ]
motorEMI <- merge(x=EMI, y=motorSCC, by="SCC")
motorBalEMI <- subset(motorEMI, motorEMI$fips=="24510")

aggMotorBalEMI <- aggregate(Emissions ~ year, motorBalEMI, sum)

ggplot(data = aggMotorBalEMI, aes(x=year, y=Emissions)) + geom_line() + geom_text(aes(label=Emissions), vjust=-2)+ geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Emissions (thousands of tons)" ) + ggtitle("Baltimore Emissions from Motorcycle")
dev.copy(png, filename=pngPath)
dev.off ()
