## Programming Assignment 3
## 06.28.2015

## [4] Ranking Hospitals in ALL STATES

rankall <- function(outcome, num = "best") {
  ##install packages
  install.packages("dplyr")
  library(dplyr)
  
  ## Read outcome data
  outcome_data <- read.csv("outcome-of-care-measures.csv", stringsAsFactors = FALSE)  
  
  ## Check that state and outcome are valid
  states <- as.factor(unique(outcome_data$State)) #list of unique states in the dataset
  
  ## check outcomes are valid
  ##check outcome is valid
  outcome_valid <- c("heart attack", "heart failure", "pneumonia") #list of valid outcomes
  outcomes_indicator <- c(11,17,23) ## list of valid indices for outcomes
    indicator <- match(tolower(outcome), outcome_valid, nomatch = 0) #identify the index of outcome wanted
    indicator <- outcomes_indicator[indicator] #index in dat of outcome wanted
  
  if (indicator == 0) { #no match found
    stop ("invalid outcome")
  }
  
  #subset data for specified outcome
  hospitals.all <- outcome_data[,c(2,7,indicator)]
  
  # remove NAs
  hospitals.all[,3] <- (as.numeric(hospitals.all[,3]))
  hospitals.all <-na.omit(hospitals.all)
  colnames(hospitals.all) <- c("hospital", "State", "outcome.value")
  
  #max rank allowed
  max.rank <-max(table(hospitals.all$State))
  
  ## check that num is valid  
  if (num=="best" {
    num <- 1
  } else if (num=="worst") {
  } else {
    num <- as.numeric(num)
    if (is.na(num)){
      stop("Invalid Num")
    }else if (num > max.rank){
      return(NA)
    }
  }
  
  #rank all hospitals by mortality rate and name of hospital (to break ties)
  hospitals.all[order(hospitals.all[3], hospitals.all[1]),] -> hospitals.ranked
  #split data by state (produces a list of data_frames, subset by state)
  hospitals.by.state<- split(hospitals.all, hospitals.all$State)
  
  lapply(hospitals.by.state, function(i) { i[2,] }) -> test
  
  if (num=="worst"){
    results.by.state <- lapply(hospitals.by.state, function(x) {x[nrow(x),]})
  } else {
    results.by.state <- lapply(hospitals.by.state, function(x){ x[num,]})
  }
  
  results <- as.data.frame(do.call(rbind, results.by.state))
  #rownames are States
  results[1,]<-rownames(results)
  #reverse the order
  results <- results[, 2:1]
  #match column names to exact output
  colnames(results) <- c("hospital", "state")
  #return results
  results
  
}
