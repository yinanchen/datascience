# TODO: Add comment
# 
# Author: yachenq
###############################################################################

#Q1
data <- read.csv(path)
rowcount <- length(na.omit(subset(data, VAL == "24")$VAL))
print(rowcount)

#Q3
#install.packages("xlsx")
library(xlsx)
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx(path,sheetIndex=1, rowIndex=rowIndex, colIndex=colIndex)
sum(dat$Zip*dat$Ext,na.rm=T)

## Alternative way to read excel
#library(readxl)
#data <- read_excel(path,sheet="NGAP Sample Data")

#Q4
## xmlParse is not able to deal with https
destPath = path
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",destfile = destPath)
#library(XML)
#library(RCurl)
#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
#xData <- getURL(fileUrl)
#doc <- xmlParse(xData)
doc <- xmlTreeParse(destPath,useInternal=TRUE)
rootNode <- xmlRoot(doc)
zipcode <- xpathSApply(rootNode,"//zipcode",xmlValue)
length(which(zipcode=="21231"))



#Q5
library(data.table)
destPath = path
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile = destPath)
data <- fread(destPath)
system.time(data[,mean(pwgtp15),by=SEX], )

system.time(sapply(split(data$pwgtp15,data$SEX),mean))

system.time(mean(data[data$SEX==1,]$pwgtp15))
system.time(mean(data[data$SEX==2,]$pwgtp15))

system.time(mean(data$pwgtp15,by=data$SEX))

system.time(rowMeans(data)[data$SEX==1])
system.time(rowMeans(data)[data$SEX==2])

system.time(tapply(data$pwgtp15,data$SEX,mean))


