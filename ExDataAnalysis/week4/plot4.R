# TODO: Add comment
# 
# Author: yachenq
###############################################################################

# Read data
scc_summary_data <- readRDS("/project/week4/NEI_data/summarySCC_PM25.rds")
scc_data <- readRDS("/project/week4/NEI_data/Source_Classification_Code.rds")
pngPath <- "/project/week4/plot4.png"

# Subset and merge two dataset
coalScc <- scc_data[grepl('Coal', scc_data$Short.Name, fixed=T), ]
merge_data <- merge(x=scc_summary_data, y=coalScc, by="SCC")

# Aggregation
aggCoalEmi <- aggregate(Emissions ~ year, merge_data, sum)

ggplot(data = aggCoalEmi, aes(x=year, y=Emissions)) + geom_line() + geom_text(aes(label=Emissions), vjust=1)+ geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Emissions (tons)" ) + ggtitle("Total United States PM2.5 Coal Emissions")

dev.copy(png, filename=pngPath)
dev.off ()
