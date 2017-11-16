LeadersLaggards <- function(index, period){
   
   library(stringr)
   
   load('R:/David/Projects/Economic & Market Summary/Data/dat.RData')
   
   full.returns <- dat$member.returns[[index]]
   returns <- full.returns[,period]
   
   names(returns) <- 'return'
   returns <- data.frame(tick = word(row.names(full.returns)),
                                     returns = returns)
   
   returns <- returns[order(returns$return, decreasing = TRUE),]
   
   
   lead <- returns
   
   lag <- returns[order(returns$return),]
   
   topBtm <- list(leaders = lead,
                  laggards = lag)
   
   return(topBtm)
}