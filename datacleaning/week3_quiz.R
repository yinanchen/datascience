# TODO: Add comment
# 
# Author: yachenq
###############################################################################

#Q1
data <- read.csv("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Data cleaning/housing.csv")
agricultureLogical <- as.logical(data$ACR==3 & data$AGS ==6)
head(rownames(data[which(agricultureLogical),]), 3)
#"125" "238" "262"

#Q2
#install.packages("jpeg")
library(jpeg)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
destPath = "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Data cleaning/jeff.jpeg"
download.file(fileUrl, mode = "wb",destfile = destPath) 
jp <- readJPEG(destPath, native = TRUE)
quantile(jp, c(.30,.80))
#      30%       80% 
#-15259150 -10575416 


#Q3
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
destPath = "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Data cleaning/GDP.csv"
destPath2 = "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Data cleaning/stats_country.csv"
# Using method = "curl" doesn't seem to work on Windows
download.file(fileUrl, destfile = destPath)
download.file(fileUrl2, destfile = destPath2)

gdp <- na.omit(read.csv(destPath, header = TRUE, skip=3, nrows = 191, skipNul=TRUE)[, c(1,2,4,5)])
edu <- read.csv(destPath2)
result <- merge(gdp, edu, by.x = "X", by.y = "CountryCode")
final <- result[order(-result[,2]),][13,]
#189 matches, 13th country is St. Kitts and Nevis


#Q4
mean(result$Ranking[result$Income.Group=="High income: OECD"])
#32.96667
mean(result$Ranking[result$Income.Group=="High income: nonOECD"])
#91.91304

#Q5
breaks <- quantile(result$Ranking, probs = seq(0, 1, 0.2), na.rm = TRUE)
result$quantileGDP <- cut(result$Ranking, breaks = breaks)
nrow(result[which(result$Income.Group == "Lower middle income" & result$quantileGDP == "(1,38.6]"),])
#5




