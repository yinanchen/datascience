# TODO: Add comment
# 
# Author: yachenq
###############################################################################


rankhospital <- function(state, outcome, num = "best") {
	#state = "TX"
	#outcome = "pneumonia"
	#num = 10
	
	## Check that state and outcome are valid
	valid_outcomes <- c('heart attack', 'heart failure', 'pneumonia')
	valid_states <- unique(input$State)
	if (!state %in% valid_states) stop('invalid state')
	if (!outcome %in% valid_outcomes) stop('invalid outcome')
	
	## Read outcome data
	columns <- c(11, 17, 23)
	names(columns) <- valid_outcomes
	outcomeIdx <- columns[outcome]
	
	input <- read.csv(fpath1, colClasses = "character")
	data <- suppressWarnings(data.frame(State=input$State, HospitalName=input$Hospital.Name, 
					DeathRate = as.numeric(input[,outcomeIdx])))
	## remove missing values
	completedata <- na.omit(data)
	
	## match outcome and column index
	
	filterbystate <- subset(completedata, completedata$State == state, select = c(2,3))
	## Return hospital name in that state with lowest 30-day death
	## rate
	sortdata <- filterbystate[order(filterbystate[,2], filterbystate[,1]),]
	
	if (num == 'best'){
		numtmp = 1
	}else if (num == 'worst'){
		numtmp = nrow(sortdata)
	}else if (!num %in% 1:nrow(sortdata)){
		return (NA)
	}else{
		numtmp = num
	}
	
	#test <- sortdata[num,]$HospitalName
	return (sortdata[numtmp,]$HospitalName)
}

#Test function
print(rankhospital("NY", "heart attack", 7))
#print(rankhospital("TX", "heart failure", 4))
#print(rankhospital("MD", "heart attack", "worst"))
#print(rankhospital("MN", "heart attack", 5000))
