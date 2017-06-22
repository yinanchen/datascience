# TODO: Add comment
# 
# Author: yachenq
###############################################################################

library(ggplot2)
# Read data
scc_summary_data <- readRDS("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/NEI_data/summarySCC_PM25.rds")
scc_data <- readRDS("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/NEI_data/Source_Classification_Code.rds")
pngPath <- "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/plot3.png"

subset_summary_data <- subset(scc_summary_data, scc_summary_data$fips=="24510")

# Aggregation
aggEmi <- aggregate(Emissions ~ year+type, subset_summary_data, sum)

ggplot(data=aggEmi, aes(x=year, y=Emissions, group=type, color=type)) + geom_line() + geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Emissions (tons)") 
dev.copy(png, filename=pngPath)
dev.off ()
