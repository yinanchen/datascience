# TODO: Add comment
# 
# Author: yachenq
###############################################################################

# Read data
scc_summary_data <- readRDS("/project/week4/NEI_data/summarySCC_PM25.rds")
scc_data <- readRDS("/project/week4/NEI_data/Source_Classification_Code.rds")
pngPath <- "/project/week4/plot1.png"

# Aggregation
aggEmi <- aggregate(Emissions ~ year, scc_summary_data, sum)

barplot(aggEmi$Emissions/1000, names.arg = aggEmi$year, main = expression('Total Emission of PM'[2.5]), xlab = 'Year', ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.copy(png, file=pngPath)
dev.off()
