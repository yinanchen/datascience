## plot6.R ##
library(plyr)
library(ggplot2)

scc_summary_data <- readRDS("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/NEI_data/summarySCC_PM25.rds")
scc_data <- readRDS("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/NEI_data/Source_Classification_Code.rds")
pngPath <- "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Exploratory Data Analysis/project/week4/plot4.png"

motor_scc <- scc_data[grepl('vehicle', scc_data$scc_data.Level.Two, ignore.case=T), ]
merge_data <- merge(x=scc_summary_data, y=motor_scc, by="SCC")
motor_bal_emi <- subset(merge_data, merge_data$fips=="24510" )
motor_la_emi <-  subset(merge_data, merge_data$fips=="06037")
motor_bal_emi$city <- "Baltimore"
motor_la_emi$city <- "Los Angeles"
motor_merge_emi <- rbind(motor_bal_emi, motor_la_emi)

agg_data <- aggregate(Emissions ~ year+city, motor_merge_emi, sum)

g <- ggplot(agg_data, aes(year, Emissions, color = city))
g + geom_line() + xlab("Year") + ylab(expression("Total PM2.5 Emissions")) + ggtitle("Total Emissions from motor vehicle in Baltimore and Los Angeles")

dev.copy(png, filename=pngPath)
dev.off ()
