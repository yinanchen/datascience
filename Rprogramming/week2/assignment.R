# TODO: Add comment
# 
# Author: yachenq
###############################################################################
## Part 1

pollutantmean <- function(directory, pollutant, id = 1:332){
	filenames <- list.files(path=directory, pattern= '*.csv')
	
	allData <- {}
	for(f in filenames){
		fid <- as.numeric(gsub(".csv","",f))
		if(fid %in% id){
			filePath <- paste(directory, f, sep="/")
			#print(filePath)
			singleData <- read.csv(filePath, header = T)
			allData <- rbind(allData, singleData)
		}
	}
	
	return(mean(allData[,pollutant], na.rm = T))
}


#sulfate, nitrate
#x <- pollutantmean("directory","nitrate")
#print(x)

# Other ref
#setwd("directory")
#lista_tot1 = list.files(pattern="*.csv");
#lista_tot2 = lapply(lista_tot1, read.csv, sep = ",")#stampa tutti i csv                                  
#lista_tot3<-do.call("rbind", lista_tot2)
#lista_tot<-lista_tot3[is.element(lista_tot3$ID, 3:4),]
#media<-mean(lista_tot$nitrate, na.rm=TRUE)


## Part 2

complete <- function(directory, id = 1:332){
	filenames <- list.files(path=directory, pattern= '*.csv')
	
	allData <- {}
	for(f in filenames){
		fid <- as.numeric(gsub(".csv","",f))
		if(fid %in% id){
			filePath <- paste(directory, f, sep="/")
			singleData <- read.csv(filePath, header = T)
			allData <- rbind(allData, data.frame(id= fid, nobs = sum(complete.cases(singleData))))
		}
	}
	return (allData)
}

set.seed(42)
#cc <- complete("directory", 332:1)
#use <- sample(332, 10)
#print(cc[use, "nobs"])

## Part 3

corr <- function(directory, threshold = 0){
	allComplete <- complete(directory)
	filteredComplete <- subset(allComplete, nobs > threshold)
	#print(nrow(filteredComplete))
	
	filenames <- list.files(path=directory, pattern= '*.csv')
	j <- 1
	#corr_vector <- numeric(length=nrow(filteredComplete))
	corr_vector <- rep(0, length=nrow(filteredComplete))
	
	for(f in filenames){
		fid <- as.numeric(gsub(".csv","",f))
		if(fid %in% filteredComplete$id){
			filePath <- paste(directory, f, sep="/")
			singleData <- na.omit(read.csv(filePath, header = T))
			corr_vector[j] <- cor(x=singleData$sulfate,y=singleData$nitrate)
			j <- j + 1
		}
	}
	return(corr_vector)
}

#x <- corr("directory", 5000)
#cr <- corr("directory")                
#cr <- sort(cr)                
#set.seed(868)                
#out <- round(cr[sample(length(cr), 5)], 4)
#print(out)

#cr <- corr("directory", 129)                
#cr <- sort(cr)                
#n <- length(cr)                
#set.seed(197)                
#out <- c(n, round(cr[sample(n, 5)], 4))
#print(out)

cr <- corr("directory", 2000)                
n <- length(cr)                
cr <- corr("directory", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))
