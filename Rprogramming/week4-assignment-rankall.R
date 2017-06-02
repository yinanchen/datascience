# TODO: Add comment
# 
# Author: yachenq
###############################################################################


rankall <- function(outcome, num = "best") {
	#outcome = "pneumonia"
	#num = "worst"
	
	## Check that state and outcome are valid
	valid_outcomes <- c('heart attack', 'heart failure', 'pneumonia')
	valid_states <- unique(input$State)
	if (!state %in% valid_states) stop('invalid state')
	if (!outcome %in% valid_outcomes) stop('invalid outcome')
	
	## match outcome and column index
	columns <- c(11, 17, 23)
	names(columns) <- valid_outcomes
	outcomeIdx <- columns[outcome]
	## Read outcome data
	input <- read.csv(fpath1, colClasses = "character")
	data <- suppressWarnings(data.frame(State=input$State, HospitalName=input$Hospital.Name, 
					DeathRate = as.numeric(input[,outcomeIdx])))
	## remove missing values
	df <- na.omit(data)
	
	## Return hospital name in that state with lowest 30-day death
	## rate
	df <- split(df, df$State)
	finalrank <- {}
	for (subdf in df){
		if (num == 'best'){
			numtmp = 1
		}else if (num == "worst"){
			numtmp = nrow(subdf)
		}else{
			numtmp = num
		}
		
		sortdata <- subdf[order(subdf[,3], subdf[,2]),]
		rankdata <- sortdata[numtmp,]
		finalrank <- rbind(finalrank, data.frame(hospital= rankdata$HospitalName, state = sortdata$State[1]))
	}
	#print(tail(finalrank, 3))
	return(finalrank)
}

#Test function
#print(head(rankall("heart attack", 20), 10))
#print(tail(rankall("pneumonia", "worst"), 3))
#print( tail(rankall("heart failure"), 10))

r <- rankall("heart failure", 10)
print(as.character(subset(r, state == "NV")$hospital))

