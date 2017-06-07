# TODO: Add comment
# 
# Author: yachenq
###############################################################################

#Q1
data <- read.csv("D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Data cleaning/housing.csv")
varNames <- names(data)
varNamesSplit <- strsplit(varNames, "wgtp")[[123]]
#""   "15"


#Q2
destPath = "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Data cleaning/GDP.csv"
data <- read.csv(destPath, header = TRUE, skip=4, nrows = 190, skipNul=TRUE)[, 5]
data <- as.numeric(gsub(",", "", data[gdp != ""]))
mean(data, na.rm=TRUE)
#377652.4

#Q3
destPath = "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Data cleaning/GDP.csv"
data <- read.csv(destPath, header = TRUE, skip=4, nrows = 190, skipNul=TRUE)[, 4]
length(grep("*United", data)) #3 Any charactres
length(grep("^United", data)) #3 TRUE
length(grep("United$", data)) #3 Ends with United

#Q4
destPath = "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Data cleaning/GDP.csv"
destPath2 = "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Data cleaning/stats_country.csv"
gdp <- na.omit(read.csv(destPath, header = TRUE, skip=3, nrows = 191, skipNul=TRUE)[, c(1,2,4,5)])
edu <- read.csv(destPath2)
result <- merge(gdp, edu, by.x = "X", by.y = "CountryCode")
length(grep("*Fiscal year end: June*",result$Special.Notes))
#13


#Q5
#Unable to download inside company
#install.packages('quantmod')
#library(quantmod)
#amzn = getSymbols("AMZN",auto.assign=FALSE)
#sampleTimes = index(amzn)
#addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
#250, 47

##        Friday Monday Thursday Tuesday Wednesday  Sum
##   2007     51     48       51      50        51  251
##   2008     50     48       50      52        53  253
##   2009     49     48       51      52        52  252
##   2010     50     47       51      52        52  252
##   2011     51     46       51      52        52  252
##   2012     51     47       51      50        51  250
##   2013     51     48       50      52        51  252
##   2014     15     14       16      16        16   77
##   Sum     368    346      371     376       378 1839


