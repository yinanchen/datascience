# https://github.com/benjamin-chan/GettingAndCleaningData/blob/master/Quiz2/quiz2.Rmd
# https://github.com/aurquhart/cleaningdataR/blob/master
# 
# Author: yachenq
###############################################################################
library(httr)
library(httpuv)
library(jsonlite)


# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",key = "123", secret = "123456")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
output <- content(req)
list(output[[4]]$name, output[[4]]$created_at)


#Q2
library(data.table)
library(sqldf)
install.packages("sqldf")
#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
destPath = "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Data cleaning/fss06pid.csv"
acs <- fread(destPath)
query1 <- sqldf("select pwgtp1 from acs where AGEP < 50") ##YES
query2 <- sqldf("select pwgtp1 from acs")  ## NO
query3 <- sqldf("select * from acs where AGEP < 50 and pwgtp1")  ## NO
query4 <- sqldf("select * from acs where AGEP < 50")  ## NO


#Q3
gold <- unique(acs$AGEP)
query1 <- sqldf("select distinct AGEP from acs") #YES
query2 <- sqldf("select AGEP where unique from acs") # NO - syntax error
query3 <- sqldf("select unique * from acs")   # NO - syntax error
query4 <- sqldf("select unique AGEP from acs")  # NO - syntax error


#Q4
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))
#45 31  7 25

#Q5
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
destPath = "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/Data cleaning/Fwksst8110.csv"
# Using method = "curl" doesn't seem to work on Windows
download.file(fileUrl, destfile = destPath)

# Using method = "curl" on OS X works
#download.file(fileUrl, destfile = "./data/q5_data.for", method = "curl")
#list.files('./data/')

q5_df <- read.fwf(file = destPath, widths = c(15, 4, 1, 3, 5, 4), header = FALSE, sep = "\t", skip = 4)
head(q5_df)

sum(q5_df$V6) # 32426.7
