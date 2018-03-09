best <- function(state, outcome1) {
  
  ## Read outcome data
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  outcome[, 11] <- as.numeric(outcome[, 11])
  outcome[, 17] <- as.numeric(outcome[, 17])
  outcome[, 23] <- as.numeric(outcome[, 23])
 
  outcome_state <- outcome[outcome$State == state,]
  
  ## Check that state and outcome are valid
  if(outcome1 == "heart attack")
  {
    
    outcome_heart_attack <- outcome_state[,11]
    minvalue = min(outcome_heart_attack,na.rm = T)
    min_index <- which(outcome_heart_attack == minvalue)
    hosp_name <- outcome_state[min_index, 2]
    
    
  }  
  else if(outcome1 == "heart failure")
  {
    outcome_heart_attack <- outcome_state[,17]
    minvalue = min(outcome_heart_attack,na.rm = T)
    min_index <- which(outcome_heart_attack == minvalue)
    hosp_name <- outcome_state[min_index, 2]
    
  }
  else if(outcome1 == "pneumonia")
  {
    
    outcome_heart_attack <- outcome_state[,23]
    minvalue = min(outcome_heart_attack,na.rm = T)
    min_index <- which(outcome_heart_attack == minvalue)
    hosp_name <- outcome_state[min_index, 2]
    
  }
  ## Return hospital name in that state with lowest 30-day death
  
 return(hosp_name)
  ## rate
  
}
