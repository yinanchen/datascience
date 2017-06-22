# TODO: Add comment
# 
# Author: yachenq
###############################################################################

# Read data
scc_summary_data <- readRDS("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/NEI_data/summarySCC_PM25.rds")
scc_data <- readRDS("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/NEI_data/Source_Classification_Code.rds")
pngPath <- "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/plot2.png"

subset_summary_data <- subset(scc_summary_data, scc_summary_data$fips=="24510")

# Aggregation
aggEmi <- aggregate(Emissions ~ year, subset_summary_data, sum)

barplot(aggEmi$Emissions/1000, names.arg = aggEmi$year, main = expression(paste('Total Emission of PM',''[2.5], ' in Baltimore City')), xlab = 'Year', ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.copy(png, file=pngPath)
dev.off()

