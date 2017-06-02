# TODO: Add comment
# 
# Author: yachenq
###############################################################################


# 1. Plot the 30-day mortality rates for heart attack
fpath1 = "D:/Users/yachenq/Documents/ML/Course Training/Data Science Program/R programming/rprog%2Fdata%2FProgAssignment3-data/outcome-of-care-measures.csv"

#outcome <- read.csv(fpath1, colClasses = "character")
#head(outcome)
#outcome[, 11] <- as.numeric(outcome[, 11])
### You may get a warning about NAs being introduced; that is okay
#hist(outcome[, 11])


# 2. Finding the best hospital in a state
best <- function(state, outcome) {
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
					DeathRate = as.numeric(input[, outcomeIdx])))
	## remove missing values
	completedata <- na.omit(data)

	filterbystate <- subset(completedata, completedata$State == state, select = c(2, 3))
	## Return hospital name in that state with lowest 30-day death
	## rate
	sortdata <- head(filterbystate[order(filterbystate[,2]),], n=1)
	return (sortdata$HospitalName)
}

#Test function
print(best("SC", "heart attack"))
#print(best("TX", "heart attack"))
#print(best("TX", "heart failure"))
#print(best("MD", "heart attack"))
#print(best("MD", "pneumonia"))
#print(best("BB", "heart attack"))
#print(best("NY", "heart attack"))
